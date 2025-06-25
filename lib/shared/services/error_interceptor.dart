// ignore_for_file: deprecated_member_use

// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:uni_sphere_admin/shared/utils/helper/colored_print.dart' show printR;

// 🌎 Project imports:
import '../../common/constant/app_strings.dart';
import 'exception/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    printR(err.response?.data);
    if (err.error is SocketException) {
      err = err.copyWith(
          error: AppException.known(AppStrings.noInternetConnection));
      handler.reject(err);
    } else if (err.response.toString().isNotEmpty &&
        err.response?.data is Map &&
        err.response?.data?["message"] != null) {
      if (err.response?.data?["message"]
              .toLowerCase()
              .contains("user not found") ||
          err.response?.data?["message"]
              .toLowerCase()
              .contains("email or password wrong")) {
        err = err.copyWith(error: AppException.known(""));
        handler.reject(err);
      } else if (err.response?.data?["message"]
          .toLowerCase()
          .contains("email is not exist")) {
        err = err.copyWith(error: AppException.known(""));
        handler.reject(err);
      } else if (err.response?.data?["message"]
          .toLowerCase()
          .contains("wrong code")) {
        err = err.copyWith(error: AppException.known(""));
        handler.reject(err);
      } else if (err.response?.data?["message"]
          .toLowerCase()
          .contains("already exist")) {
        err = err.copyWith(error: AppException.known(""));
        handler.reject(err);
      } else {
        err = err.copyWith(
            error: AppException.known(err.response?.data?["message"] ??
                AppStrings.pleaseTryAgainLater));
        handler.reject(err);
      }
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.receiveTimeout) {
      err = err.copyWith(
          error: AppException.known(AppStrings.noInternetConnection));
      handler.reject(err);
    } else if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 500) {
      err = err.copyWith(
          error: AppException.known(AppStrings.pleaseTryAgainLater));
      handler.next(err);
    } else if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 403) {
      err = err.copyWith(
          error: AppException.known(AppStrings.insufficientPermissions));
      handler.next(err);
    } else if (err.type == DioExceptionType.badResponse) {
      var data = err.response?.data;
      err = err.copyWith(
          error: data is String
              ? AppException.known(data)
              : AppException.unknown());
      handler.next(err);
    } else {
      err = err.copyWith(error: AppException.unknown());
      handler.next(err);
    }
  }
}
