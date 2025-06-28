class SubjectGrade {
  final String subjectId;
  final int passGrade;
  final List<StudentGrade> studentGrades;

  SubjectGrade({
    required this.subjectId,
    required this.passGrade,
    required this.studentGrades,
  });

  factory SubjectGrade.fromJson(Map<String, dynamic> json) {
    return SubjectGrade(
      subjectId: json['subjectId'],
      passGrade: json['passGrade'],
      studentGrades: (json['studentGrades'] as List)
          .map((e) => StudentGrade.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'passGrade': passGrade,
      'studentGrades': studentGrades.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentGrade {
  final String studentId;
  final int midTermGrade;
  final int finalGrade;

  StudentGrade({
    required this.studentId,
    required this.midTermGrade,
    required this.finalGrade,
  });

  factory StudentGrade.fromJson(Map<String, dynamic> json) {
    return StudentGrade(
      studentId: json['studentId'],
      midTermGrade: json['midTermGrade'],
      finalGrade: json['finalGrade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'midTermGrade': midTermGrade,
      'finalGrade': finalGrade,
    };
  }
}
