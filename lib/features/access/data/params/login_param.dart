class LoginParam {
  final String gmail;
  final String? id;
  final String password;
  LoginParam({
    this.id,
    required this.password,
    required this.gmail,
  });

  Map<String, dynamic> toAdminJson() {
    return {
      'gmail': gmail,
      'majorId': id,
      'password': password,
    };
  }

  Map<String, dynamic> toSuperAdminJson() {
    return {
      'gmail': gmail,
      'facultyId': id,
      'password': password,
    };
  }

  Map<String, dynamic> toProfessorJson() {
    return {
      'gmail': gmail,
      'password': password,
    };
  }

  Map<String, dynamic> toSystemControllerJson() {
    return {
      'gmail': gmail,
      'password': password,
    };
  }
}
