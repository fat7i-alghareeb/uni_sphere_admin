class RegisterParam {
  final String id;
  final String password;
  final String confirmPassword;

  RegisterParam({
    required this.id,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toAdminJson() {
    return {
      'userName': id,
      'adminId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  Map<String, dynamic> toSuperAdminJson() {
    return {
      'userName': id,
      'superAdminId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  Map<String, dynamic> toProfessorJson() {
    return {
      'userName': id,
      'professorId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  Map<String, dynamic> toSystemControllerJson() {
    return {
      'userName': id,
      'systemControllerId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
