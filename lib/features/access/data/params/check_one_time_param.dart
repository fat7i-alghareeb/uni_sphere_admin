class CheckOneTimeParam {
  final String gmail;
  final String code;
  final String? id;

  CheckOneTimeParam({
    required this.gmail,
    required this.code,
    this.id,
  });

  Map<String, dynamic> toAdminJson() {
    return {
      'gmail': gmail,
      'code': code,
      'majorId': id,
    };
  }

  Map<String, dynamic> toSuperAdminJson() {
    return {
      'gmail': gmail,
      'code': code,
      'facultyId': id,
    };
  }

  Map<String, dynamic> toProfessorJson() {
    return {
      'gmail': gmail,
      'code': code,
    };
  }
}
