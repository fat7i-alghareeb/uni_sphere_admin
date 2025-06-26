class CheckOneTimeParam {
  final String gmail;
  final String code;
  final String majorId;

  CheckOneTimeParam({
    required this.gmail,
    required this.code,
    required this.majorId,
  });

  Map<String, dynamic> toAdminJson() {
    return {
      'gmail': gmail,
      'code': code,
      'majorId': majorId,
    };
  }

  Map<String, dynamic> toSuperAdminJson() {
    return {
      'gmail': gmail,
      'code': code,
      'facultyId': majorId,
    };
  }

  Map<String, dynamic> toProfessorJson() {
    return {
      'gmail': gmail,
      'code': code,
    };
  }
}
