class ItemModel {
  final String id;
  final String subjectName;
  final String lectureName;
  final String lectureHall;
  final String startTime;
  final String endTime;

  ItemModel({
    required this.id,
    required this.subjectName,
    required this.lectureName,
    required this.lectureHall,
    required this.startTime,
    required this.endTime,
  });

      factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String,
      subjectName: json['subjectName'] as String,
      lectureName: json['lectureName'] as String,
      lectureHall: json['lectureHall'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'lectureName': lectureName,
      'lectureHall': lectureHall,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}