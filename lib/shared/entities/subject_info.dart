class SubjectInfo {
  final String id;
  final String name;
  SubjectInfo({required this.id, required this.name});

  factory SubjectInfo.fromMap(Map<String, dynamic> map) {
    return SubjectInfo(
      id: map['id'],
      name: map['name'],
    );
  }
}
