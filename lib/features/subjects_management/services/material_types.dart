import 'package:flutter/material.dart';

/// Enum for different material types
enum MaterialType {
  image,
  pdf,
  document,
  excel,
  powerpoint,
  text,
  archive,
  video,
  audio,
  link,
  unknown,
}

/// Extension to provide utility methods for MaterialType
extension MaterialTypeExtension on MaterialType {
  /// Get common name for the material type
  String get commonName {
    switch (this) {
      case MaterialType.image:
        return 'Image';
      case MaterialType.pdf:
        return 'PDF Document';
      case MaterialType.document:
        return 'Document';
      case MaterialType.excel:
        return 'Excel Spreadsheet';
      case MaterialType.powerpoint:
        return 'PowerPoint Presentation';
      case MaterialType.text:
        return 'Text File';
      case MaterialType.archive:
        return 'Archive';
      case MaterialType.video:
        return 'Video';
      case MaterialType.audio:
        return 'Audio';
      case MaterialType.link:
        return 'Web Link';
      case MaterialType.unknown:
        return 'File';
    }
  }

  /// Get icon for the material type
  IconData get icon {
    switch (this) {
      case MaterialType.image:
        return Icons.image_rounded;
      case MaterialType.pdf:
        return Icons.picture_as_pdf_rounded;
      case MaterialType.document:
        return Icons.description_rounded;
      case MaterialType.excel:
        return Icons.table_chart_rounded;
      case MaterialType.powerpoint:
        return Icons.slideshow_rounded;
      case MaterialType.text:
        return Icons.text_snippet_rounded;
      case MaterialType.archive:
        return Icons.archive_rounded;
      case MaterialType.video:
        return Icons.video_file_rounded;
      case MaterialType.audio:
        return Icons.audio_file_rounded;
      case MaterialType.link:
        return Icons.link_rounded;
      case MaterialType.unknown:
        return Icons.insert_drive_file_rounded;
    }
  }

  /// Get color for the material type
  Color get color {
    switch (this) {
      case MaterialType.image:
        return Colors.green;
      case MaterialType.pdf:
        return Colors.red;
      case MaterialType.document:
        return Colors.blue;
      case MaterialType.excel:
        return Colors.green;
      case MaterialType.powerpoint:
        return Colors.orange;
      case MaterialType.text:
        return Colors.grey;
      case MaterialType.archive:
        return Colors.purple;
      case MaterialType.video:
        return Colors.red;
      case MaterialType.audio:
        return Colors.blue;
      case MaterialType.link:
        return Colors.blue;
      case MaterialType.unknown:
        return Colors.grey;
    }
  }

  /// Check if material can be viewed in-app
  bool get canViewInApp {
    return this == MaterialType.image;
  }

  /// Check if material can be downloaded
  bool get canDownload {
    return this != MaterialType.link;
  }

  /// Get action text for the material type
  String get actionText {
    switch (this) {
      case MaterialType.link:
        return 'Open Link';
      case MaterialType.image:
        return 'View';
      default:
        return 'Download & Open';
    }
  }

  /// Get action icon for the material type
  IconData get actionIcon {
    switch (this) {
      case MaterialType.link:
        return Icons.open_in_new;
      case MaterialType.image:
        return Icons.visibility;
      default:
        return Icons.download_rounded;
    }
  }
}

/// Utility class for material type operations
class MaterialTypeUtils {
  /// Get material type from file extension
  static MaterialType getTypeFromExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return MaterialType.pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'svg':
      case 'webp':
        return MaterialType.image;
      case 'doc':
      case 'docx':
      case 'rtf':
        return MaterialType.document;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return MaterialType.excel;
      case 'ppt':
      case 'pptx':
        return MaterialType.powerpoint;
      case 'txt':
      case 'md':
        return MaterialType.text;
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
        return MaterialType.archive;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
      case 'flv':
      case 'mkv':
        return MaterialType.video;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
      case 'ogg':
        return MaterialType.audio;
      default:
        return MaterialType.unknown;
    }
  }

  /// Get material type from URL
  static MaterialType getTypeFromUrl(String url) {
    if (url.startsWith('http') && !url.contains('.')) {
      return MaterialType.link;
    }

    final fileName = url.split('/').last;
    if (fileName.contains('.')) {
      final extension = fileName.split('.').last.toLowerCase();
      return getTypeFromExtension(extension);
    }

    return MaterialType.unknown;
  }

  /// Get file extension from URL
  static String getFileExtension(String url) {
    final fileName = url.split('/').last;
    if (fileName.contains('.')) {
      return fileName.split('.').last.toLowerCase();
    }
    return '';
  }

  /// Check if file type is restricted (video/audio)
  static bool isRestrictedFileType(String extension) {
    final type = getTypeFromExtension(extension);
    return type == MaterialType.video || type == MaterialType.audio;
  }

  /// Get allowed file types for upload
  static List<String> getAllowedExtensions() {
    return [
      'pdf',
      'doc',
      'docx',
      'txt',
      'rtf',
      'xls',
      'xlsx',
      'csv',
      'ppt',
      'pptx',
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'svg',
      'webp',
      'zip',
      'rar',
      '7z',
    ];
  }
}
