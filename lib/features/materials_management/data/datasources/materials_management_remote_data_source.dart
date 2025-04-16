//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/materials_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsManagementRemote {
  final Dio _dio;

  const MaterialsManagementRemote(Dio dio) : _dio = dio;

  //* Get All MaterialsManagement
  Future<MaterialsManagementModel> getAllMaterialsManagement() {
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
