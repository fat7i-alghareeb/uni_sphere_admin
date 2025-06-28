class CreateSchedule {
  final String majorId;
  final int year;
  final String scheduleDate;
  final List<Lecture> lectures;

  CreateSchedule({
    required this.majorId,
    required this.year,
    required this.scheduleDate,
    required this.lectures,
  });

  factory CreateSchedule.fromJson(Map<String, dynamic> json) {
    return CreateSchedule(
      majorId: json['majorId'],
      year: json['year'],
      scheduleDate: json['scheduleDate'],
      lectures: (json['lectures'] as List<dynamic>)
          .map((e) => Lecture.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'majorId': majorId,
        'year': year,
        'scheduleDate': scheduleDate,
        'lectures': lectures.map((e) => e.toJson()).toList(),
      };
}

class Lecture {
  final String subjectNameEn;
  final String subjectNameAr;
  final String lecturerNameEn;
  final String lecturerNameAr;
  final String startTime;
  final String endTime;
  final String lectureHallEn;
  final String lectureHallAr;

  Lecture({
    required this.subjectNameEn,
    required this.subjectNameAr,
    required this.lecturerNameEn,
    required this.lecturerNameAr,
    required this.startTime,
    required this.endTime,
    required this.lectureHallEn,
    required this.lectureHallAr,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
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
