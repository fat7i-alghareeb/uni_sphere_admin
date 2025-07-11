class StudentInfo {
  final String id;
  final String name;
  final String? studentNumber;

  StudentInfo({
    required this.id,
    required this.name,
    required this.studentNumber,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      id: json['id'],
      name: json['fullName'] ?? json['name'],
      studentNumber: json['studentNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FullName': name,
      'studentNumber': studentNumber,
    };
  }
}
