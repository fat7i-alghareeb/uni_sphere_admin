// 📦 Package imports:
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter/foundation.dart';

// 🌎 Project imports:

import '../../core/auth_data_source/local/reactive_token_storage.dart';
import '../../core/constants/app_url.dart';
import '../../core/injection/injection.dart';
import '../../core/models/auth_token_dio.dart';
import '../utils/helper/colored_print.dart' show printR;
import 'error_interceptor.dart';
import 'localization_interceptor.dart';
import 'refresh_token_helper.dart';

class DioClient with DioMixin implements Dio {
  DioClient(
    this.baseUrl, {
    List<Interceptor> interceptors = const [],
  }) {
    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    options
      ..baseUrl = baseUrl
      ..headers = {
        "accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        "Transfer-Encoding": "chunked",
        "lang": 'en',
      };
    if (interceptors.isNotEmpty) {
      this.interceptors.addAll(interceptors);
    }
    final logInterceptor = LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    );
    final tokenDio = Dio(options)
      ..interceptors.addAll([
        logInterceptor,
      ]);
    tokenDio.httpClientAdapter = httpClientAdapter;
    this.interceptors.addAll([
      RefreshTokenInterceptor<AuthTokenModel>(
        debugLog: true,
        tokenProtocol: TokenProtocol(
          shouldRefresh: (response, token) {
            printR("shouldRefresh");
            printR(response?.statusCode);
            return (response?.statusCode == 401);
          },
        ),
        onRevoked: (dioError) {
          if (dioError.response?.statusCode == 403) {}
          return null;
        },
        tokenStorage: getIt<ReactiveTokenStorage>(),
        tokenDio: tokenDio,
        refreshToken: (token, tokenDio) async {
          //  final
          try {
            final response = await tokenDio.post(
              AppUrl.refreshToken,
              data: {
                'refreshToken': token.refreshToken,
              },
              options: Options(
                headers: {
                  'lang': 'en',
                },
              ),
            );
            final authTokenModel = AuthTokenModel.fromMap(response.data);
            await updateStorageToken(token);
            return authTokenModel;
          } catch (e) {
            // getIt<AuthRepoImp>().logout();
            return AuthTokenModel(
              accessToken: '',
              refreshToken: '',
            );
          }
        },
      ),
      LocalizationInterceptor(),
      if (!kReleaseMode) logInterceptor,
      ErrorInterceptor(),
    ]);
  }

  final String baseUrl;
}
