//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/generate_otp_entity.dart';
import '../repositories/generate_otp_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GenerateOtpUsecase {
  final GenerateOtpRepo _repo;

  GenerateOtpUsecase({
    required GenerateOtpRepo repo,
  }) : _repo = repo;

  //* Get All GenerateOtp
  Future<Either<String, GenerateOtpEntity>> getAllGenerateOtp() =>
      _repo.getAllGenerateOtp();
}
