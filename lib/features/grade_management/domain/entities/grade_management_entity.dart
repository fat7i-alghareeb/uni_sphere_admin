class Grade {
  final String id;
  final String studentId;
  final String subjectId;
  final double practicalGrade;
  final double theoreticalGrade;
  Grade({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.practicalGrade,
    required this.theoreticalGrade,
  });
  double get finalGrade => practicalGrade + theoreticalGrade;
}
