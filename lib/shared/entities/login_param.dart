// ignore_for_file: public_member_api_docs, sort_constructors_first

// 📦 Package imports:
import 'package:equatable/equatable.dart';

class LoginParam extends Equatable {
  final String email;
  final String password;
  const LoginParam({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  LoginParam copyWith({
    String? email,
    String? password,
  }) {
    return LoginParam(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    // final String deviceToken =
    //     await FirebaseNotificationImplService().getToken() ?? "";
    return {
      'email': email,
      'password': password,
      //   'deviceToken': deviceToken,
    };
  }
}
