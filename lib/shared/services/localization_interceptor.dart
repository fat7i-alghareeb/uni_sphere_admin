// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/key_constants.dart';
import '../../core/injection/injection.dart';

// 🌎 Project imports:

class LocalizationInterceptor extends Interceptor {
  LocalizationInterceptor();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'lang': getIt<SharedPreferences>().getString(kLanguage) ?? 'ar',
    });
    handler.next(options);
  }
}
