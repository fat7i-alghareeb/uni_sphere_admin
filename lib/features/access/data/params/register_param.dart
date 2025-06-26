class RegisterParam {
  final String userName;
  final String id;
  final String password;
  final String confirmPassword;

  RegisterParam({
    required this.userName,
    required this.id,
    required this.password, 
    required this.confirmPassword,
  });

  Map<String, dynamic> toAdminJson() {
    return {
      'userName': userName,
      'adminId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
  Map<String, dynamic> toSuperAdminJson() {
    return {
      'userName': userName,
      'superAdminId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
  Map<String, dynamic> toProfessorJson() {
    return {
      'userName': userName,
      'professorId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
  Map<String, dynamic> toSystemControllerJson() { 
    return {
      'userName': userName,
      'systemControllerId': id,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }   
}