//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/generate_otp_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class GenerateOtpRepo {
  GenerateOtpRepo();

  //* Get All GenerateOtp
  Future<Either<String, GenerateOtpEntity>> getAllGenerateOtp();
}
