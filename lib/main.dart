// 📦 Package imports:
import 'dart:io';

// 🌎 Project imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure SSL certificate handling for all HTTP requests
  _configureHttpClient();

  await EasyLocalization.ensureInitialized();
  bootstrap(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/l10n',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

void _configureHttpClient() {
  // Configure HTTP client to handle SSL certificates globally
  final client = HttpClient();
  client.badCertificateCallback = (cert, host, port) {
    // Accept self-signed certificates for development
    return true;
  };

  // Set the global HTTP client
  HttpOverrides.global = _MyHttpOverrides();
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (cert, host, port) {
      // Accept self-signed certificates for development
      return true;
    };
    return client;
  }
}
