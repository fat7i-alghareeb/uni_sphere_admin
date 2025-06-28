class AddLectureParam {
  final String scheduleId;
  final String subjectNameEn;
  final String subjectNameAr;
  final String lecturerNameEn;
  final String lecturerNameAr;
  final String startTime;
  final String endTime;
  final String lectureHallEn;
  final String lectureHallAr;

  AddLectureParam({
    required this.scheduleId,
    required this.subjectNameEn,
    required this.subjectNameAr,
    required this.lecturerNameEn,
    required this.lecturerNameAr,
    required this.startTime,
    required this.endTime,
    required this.lectureHallEn,
    required this.lectureHallAr,
  });

  factory AddLectureParam.fromJson(Map<String, dynamic> json) {
    return AddLectureParam(
      scheduleId: json['scheduleId'],
      subjectNameEn: json['subjectNameEn'],
      subjectNameAr: json['subjectNameAr'],
      lecturerNameEn: json['lecturerNameEn'],
      lecturerNameAr: json['lecturerNameAr'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      lectureHallEn: json['lectureHallEn'],
      lectureHallAr: json['lectureHallAr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'scheduleId': scheduleId,
        'subjectNameEn': subjectNameEn,
        'subjectNameAr': subjectNameAr,
        'lecturerNameEn': lecturerNameEn,
        'lecturerNameAr': lecturerNameAr,
        'startTime': startTime,
        'endTime': endTime,
        'lectureHallEn': lectureHallEn,
        'lectureHallAr': lectureHallAr,
      };
}
