class CheckOneTimeParam {
  final String studentNumber;
  final String code;
  final String majorId;

  CheckOneTimeParam({
    required this.studentNumber,
    required this.code,
    required this.majorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentNumber': studentNumber,
      'code': code,
      'majorId': majorId,
    };
  }
}
