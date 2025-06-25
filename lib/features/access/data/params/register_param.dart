class RegisterParam {
  final String userName;
  final String studentId;
  final String password;
  final String confirmPassword;

  RegisterParam({
    required this.userName,
    required this.studentId,
    required this.password, 
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'studentId': studentId,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}