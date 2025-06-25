class LoginParam {
  final String studentNumber;
  final String majorId;
  final String password;
  LoginParam({
    required this.majorId,
    required this.password,
    required this.studentNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentNumber': studentNumber,
      'majorId': majorId,
      'password': password,
    };
  }
}
