class TimetableEntity {
  final String subjectName;
  final String lecturerName;
  final String lectureHall;
  final DateTime startTime;
  final DateTime endTime;

  TimetableEntity({
    required this.subjectName,
    required this.lecturerName,
    required this.lectureHall,
    required this.startTime,
    required this.endTime,
  });
}
