class AddLectureParam {
  final String subjectId;
  final String startTime;
  final String endTime;
  final String lectureHallEn;
  final String lectureHallAr;

  AddLectureParam({
    required this.subjectId,
    required this.startTime,
    required this.endTime,
    required this.lectureHallEn,
    required this.lectureHallAr,
  });

  factory AddLectureParam.fromJson(Map<String, dynamic> json) {
    return AddLectureParam(
      subjectId: json['subjectId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      lectureHallEn: json['lectureHallEn'],
      lectureHallAr: json['lectureHallAr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'subjectId': subjectId,
        'startTime': startTime,
        'endTime': endTime,
        'lectureHallEn': lectureHallEn,
        'lectureHallAr': lectureHallAr,
      };
}
