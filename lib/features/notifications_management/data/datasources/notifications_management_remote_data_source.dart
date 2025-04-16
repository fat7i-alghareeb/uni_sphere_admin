//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/notifications_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsManagementRemote {
  final Dio _dio;

  const NotificationsManagementRemote(Dio dio) : _dio = dio;

  //* Get All NotificationsManagement
  Future<NotificationsManagementModel> getAllNotificationsManagement() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          "random/url",
        );
        return response.data;
      },
    );
  }
}
