// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter/foundation.dart';
import 'refresh_token_helper.dart';

// 🌎 Project imports:

import '../../core/auth_data_source/local/auth_local.dart';
import '../../core/auth_data_source/local/reactive_token_storage.dart';
import '../../core/constants/app_url.dart';
import '../../core/injection/injection.dart';
import '../../core/models/auth_token_dio.dart';
import 'error_interceptor.dart';
import 'localization_interceptor.dart';

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
    httpClientAdapter = HttpClientAdapter();
    options
      ..baseUrl = baseUrl
      ..headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Transfer-Encoding": "chunked",
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
    this.interceptors.addAll([
      RefreshTokenInterceptor<AuthTokenModel>(
        debugLog: true,
        tokenProtocol: TokenProtocol(
          shouldRefresh: (response, token) {
            final user = getIt<AuthLocal>().getUser();
            String accessToken = user?.accessToken ?? '';
            return (isTokenAboutToExpire(accessToken) ||
                response?.statusCode == 401);
          },
        ),
        onRevoked: (dioError) {
          if (dioError.response?.statusCode == 403) {}
          return null;
        },
        tokenStorage: getIt<ReactiveTokenStorage>(),
        tokenDio: tokenDio,
        refreshToken: (token, tokenDio) async {
          final user = getIt<AuthLocal>().getUser();
          final response = await tokenDio.post(AppUrl.refreshToken, data: {
            'id': user?.id,
            'refreshToken': token.refreshToken,
          });
          final authTokenModel = AuthTokenModel.fromMap(response.data);
          final authTokenModel2 = AuthTokenModel(
            accessToken: authTokenModel.accessToken,
            refreshToken: authTokenModel.refreshToken ?? token.refreshToken,
          );
          await updateStorageToken(user!, token.accessToken);
          return authTokenModel2;
        },
      ),
      LocalizationInterceptor(),
      if (!kReleaseMode) logInterceptor,
      ErrorInterceptor(),
    ]);
  }

  final String baseUrl;
}
