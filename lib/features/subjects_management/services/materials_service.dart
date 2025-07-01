import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_sphere_admin/core/constants/app_url.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/services/material_types.dart'
    as mt;
import 'package:open_file/open_file.dart';

/// Service class to handle different material types and operations
class MaterialsService {
  static final MaterialsService _instance = MaterialsService._internal();
  factory MaterialsService() => _instance;

  late final Dio _dio;
  late final Dio _downloadDio;
  final Map<String, bool> _downloadedFiles = {};

  MaterialsService._internal() {
    _dio = getIt<Dio>();
    _initializeDownloadDio();
  }

  /// Initialize a dedicated Dio client for downloads with proper SSL handling
  void _initializeDownloadDio() {
    _downloadDio = Dio();

    // Configure SSL certificate handling for downloads
    if (_downloadDio.httpClientAdapter is IOHttpClientAdapter) {
      (_downloadDio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // Set timeout for downloads
    _downloadDio.options.connectTimeout = const Duration(seconds: 60);
    _downloadDio.options.receiveTimeout =
        const Duration(seconds: 300); // 5 minutes for large files
    _downloadDio.options.sendTimeout = const Duration(seconds: 60);
  }

  /// Get the full URL for a material
  String getFullUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    }
    return '${AppUrl.baseUrlDevelopment}$url';
  }

  /// Get common file name from URL (without path)
  String getCommonFileName(String url) {
    final materialType = mt.MaterialTypeUtils.getTypeFromUrl(url);
    return materialType.commonName;
  }

  /// Get file extension from URL
  String getFileExtension(String url) {
    return mt.MaterialTypeUtils.getFileExtension(url);
  }

  /// Determine material type from file extension
  MaterialsUrlType getMaterialTypeFromExtension(String extension) {
    final materialType = mt.MaterialTypeUtils.getTypeFromExtension(extension);
    switch (materialType) {
      case mt.MaterialType.pdf:
        return MaterialsUrlType.pdf;
      case mt.MaterialType.image:
        return MaterialsUrlType.image;
      case mt.MaterialType.document:
        return MaterialsUrlType.document;
      case mt.MaterialType.excel:
        return MaterialsUrlType.excel;
      case mt.MaterialType.powerpoint:
        return MaterialsUrlType.powerpoint;
      case mt.MaterialType.link:
        return MaterialsUrlType.link;
      default:
        return MaterialsUrlType.other;
    }
  }

  /// Check if material can be viewed in-app
  bool canViewInApp(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.canViewInApp;
  }

  /// Check if material can be downloaded
  bool canDownload(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.canDownload;
  }

  /// Convert MaterialsUrlType to MaterialType
  mt.MaterialType _getMaterialTypeFromUrlType(MaterialsUrlType type) {
    switch (type) {
      case MaterialsUrlType.pdf:
        return mt.MaterialType.pdf;
      case MaterialsUrlType.image:
        return mt.MaterialType.image;
      case MaterialsUrlType.document:
        return mt.MaterialType.document;
      case MaterialsUrlType.excel:
        return mt.MaterialType.excel;
      case MaterialsUrlType.powerpoint:
        return mt.MaterialType.powerpoint;
      case MaterialsUrlType.word:
        return mt.MaterialType.document;
      case MaterialsUrlType.link:
        return mt.MaterialType.link;
      case MaterialsUrlType.other:
        return mt.MaterialType.unknown;
    }
  }

  /// Check if file is already downloaded
  bool isFileDownloaded(String url) {
    return _downloadedFiles[url] ?? false;
  }

  /// Mark file as downloaded
  void markFileAsDownloaded(String url) {
    _downloadedFiles[url] = true;
  }

  /// Handle material action (view/download/open)
  Future<void> handleMaterialAction(
    BuildContext context,
    MaterialsUrl material,
  ) async {
    final fullUrl = getFullUrl(material.url);

    switch (material.type) {
      case MaterialsUrlType.link:
        await _openLink(fullUrl);
        break;
      case MaterialsUrlType.image:
        await _viewImage(context, fullUrl, material.url);
        break;
      default:
        // Check if file is already downloaded
        if (isFileDownloaded(material.url)) {
          // File is already downloaded, just open it
          await _openDownloadedFile(context, material.url);
        } else {
          // File is not downloaded, download and open it
          try {
            await _downloadAndOpenFile(context, fullUrl, material.url);
          } catch (e) {
            // If download fails, try to open in browser as fallback
            debugPrint('Download failed, trying to open in browser: $e');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Download failed. Opening in browser instead.'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
            await _openLink(fullUrl);
          }
        }
        break;
    }
  }

  /// Open link in browser
  Future<void> _openLink(String url) async {
    try {
      // Clean and validate the URL
      String cleanUrl = url.trim();

      // Ensure URL has a protocol
      if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://')) {
        cleanUrl = 'https://$cleanUrl';
      }

      // Handle special characters in URLs (like WhatsApp URLs)
      try {
        // Try to encode the URL properly
        final encodedUrl = Uri.encodeFull(cleanUrl);
        if (encodedUrl != cleanUrl) {
          cleanUrl = encodedUrl;
        }
      } catch (encodeError) {
        debugPrint('URL encoding error: $encodeError');
        // Continue with original URL if encoding fails
      }

      // Try to parse the URI
      Uri uri;
      try {
        uri = Uri.parse(cleanUrl);
      } catch (parseError) {
        debugPrint('URL parsing error: $parseError for URL: $cleanUrl');
        throw Exception('Invalid URL format: $cleanUrl');
      }

      // Check if URL can be launched
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        debugPrint('Cannot launch URL: $cleanUrl');

        // Special handling for WhatsApp URLs
        if (cleanUrl.contains('whatsapp.com') || cleanUrl.contains('wa.me')) {
          debugPrint('Attempting to handle WhatsApp URL specially');
          // For WhatsApp URLs, try without the query parameters
          try {
            final baseUrl = cleanUrl.split('?')[0];
            final baseUri = Uri.parse(baseUrl);
            if (await canLaunchUrl(baseUri)) {
              await launchUrl(baseUri, mode: LaunchMode.externalApplication);
              return;
            }
          } catch (whatsappError) {
            debugPrint('WhatsApp URL handling failed: $whatsappError');
          }
        }

        throw Exception('This URL cannot be opened: $cleanUrl');
      }

      // Try different launch modes with better error handling
      bool launched = false;

      // First try external application
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        launched = true;
      } catch (externalError) {
        debugPrint('External launch failed: $externalError');
      }

      // If external failed, try in-app browser
      if (!launched) {
        try {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
          launched = true;
        } catch (inAppError) {
          debugPrint('In-app launch failed: $inAppError');
        }
      }

      // If both failed, try platform default
      if (!launched) {
        try {
          await launchUrl(uri);
          launched = true;
        } catch (defaultError) {
          debugPrint('Default launch failed: $defaultError');
        }
      }

      if (!launched) {
        throw Exception('All launch methods failed for URL: $cleanUrl');
      }
    } catch (e) {
      debugPrint('Error opening link: $e for URL: $url');
      throw Exception('Failed to open link: $e');
    }
  }

  /// View image in-app using CustomNetworkImage
  Future<void> _viewImage(
      BuildContext context, String fullUrl, String fileName) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(getCommonFileName(fileName)),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.network(
                fullUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Failed to load image',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Download and open file
  Future<void> _downloadAndOpenFile(
    BuildContext context,
    String fullUrl,
    String fileName,
  ) async {
    try {
      if (kIsWeb) {
        throw Exception(
            'Download not supported on web. Opening in browser instead.');
      }

      // Get download directory with fallback
      Directory? directory;
      try {
        directory = await getExternalStorageDirectory();
      } catch (e) {
        debugPrint('Error getting external storage directory: $e');
      }
      if (directory == null) {
        try {
          directory = await getApplicationDocumentsDirectory();
        } catch (e) {
          debugPrint('Error getting documents directory: $e');
          throw Exception('Could not access any storage directory');
        }
      }

      final downloadsDir = Directory('${directory.path}/Downloads');
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      final filePath = '${downloadsDir.path}/${getCommonFileName(fileName)}';
      final file = File(filePath);

      // Check if file is already downloaded
      if (await file.exists()) {
        markFileAsDownloaded(fullUrl);
        await _openFile(filePath);

        return;
      }

      // Download file with better error handling
      try {
        await _downloadDio.download(
          fullUrl,
          filePath,
          onReceiveProgress: (received, total) {
            debugPrint('Download progress: $received / $total');
          },
          options: Options(
            headers: {
              'User-Agent': 'UniSphere-Admin/1.0',
            },
          ),
        );
      } catch (downloadError) {
        debugPrint('Download error: $downloadError');
        // Handle specific download errors
        if (downloadError.toString().contains('UnimplementedError')) {
          throw Exception(
              'File download is not supported on this platform. The file will be opened in your browser instead.');
        }
        if (downloadError.toString().contains('CERTIFICATE_VERIFY_FAILED') ||
            downloadError.toString().contains('HandshakeException')) {
          throw Exception(
              'SSL certificate error. Please check your server configuration or try again.');
        }
        if (downloadError.toString().contains('SocketException')) {
          throw Exception(
              'Network connection error. Please check your internet connection.');
        }
        throw Exception('Download failed: ${downloadError.toString()}');
      }

      if (!await file.exists()) {
        throw Exception('File download completed but file not found');
      }

      markFileAsDownloaded(fullUrl);
      await _openFile(filePath);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File downloaded and opened successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error in _downloadAndOpenFile: $e');
      throw Exception('Failed to download/open file: $e');
    }
  }

  /// Get material icon data
  IconData getMaterialIcon(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.icon;
  }

  /// Get material icon color
  Color getMaterialIconColor(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.color;
  }

  /// Get action button icon
  IconData getActionIcon(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.actionIcon;
  }

  /// Get view icon for downloaded files
  IconData getViewIcon() {
    return Icons.visibility;
  }

  /// Get action button text
  String getActionText(MaterialsUrlType type) {
    final materialType = _getMaterialTypeFromUrlType(type);
    return materialType.actionText;
  }

  /// Get file size in human readable format
  String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Get file size from URL (async)
  Future<String?> getFileSize(String url) async {
    try {
      final response = await _dio.head(url);
      final contentLength = response.headers.value('content-length');
      if (contentLength != null) {
        return formatFileSize(int.parse(contentLength));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if URL is accessible (for SSL certificate validation)
  Future<bool> isUrlAccessible(String url) async {
    try {
      await _dio.head(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Open file using system default app
  Future<void> _openFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        throw Exception('Could not open file: ${result.message}');
      }
      debugPrint('File opened: $filePath');
    } catch (e) {
      debugPrint('Error opening file: $e');
      throw Exception('Failed to open file: $e');
    }
  }

  /// Open already downloaded file
  Future<void> _openDownloadedFile(
      BuildContext context, String fileName) async {
    try {
      // Get download directory with fallback
      Directory? directory;
      try {
        directory = await getExternalStorageDirectory();
      } catch (e) {
        debugPrint('Error getting external storage directory: $e');
      }
      if (directory == null) {
        try {
          directory = await getApplicationDocumentsDirectory();
        } catch (e) {
          debugPrint('Error getting documents directory: $e');
          throw Exception('Could not access any storage directory');
        }
      }

      final downloadsDir = Directory('${directory.path}/Downloads');
      final filePath = '${downloadsDir.path}/${getCommonFileName(fileName)}';
      final file = File(filePath);

      if (!await file.exists()) {
        // File doesn't exist, remove from downloaded list and try to download
        _downloadedFiles.remove(fileName);
        throw Exception('File not found. Please download again.');
      }

      await _openFile(filePath);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File opened with default app'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error opening downloaded file: $e');
      throw Exception('Failed to open downloaded file: $e');
    }
  }

  /// Check if file is actually downloaded on disk
  Future<bool> isFileActuallyDownloaded(String url) async {
    try {
      Directory? directory;
      try {
        directory = await getExternalStorageDirectory();
      } catch (e) {
        debugPrint('Error getting external storage directory: $e');
      }
      if (directory == null) {
        try {
          directory = await getApplicationDocumentsDirectory();
        } catch (e) {
          debugPrint('Error getting documents directory: $e');
          return false;
        }
      }
      final downloadsDir = Directory('${directory.path}/Downloads');
      final filePath = '${downloadsDir.path}/${getCommonFileName(url)}';
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }
}
