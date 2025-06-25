class Faculty {
  final String id;
  final String name;

  Faculty({required this.id, required this.name});

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(id: map['id'], name: map['name']);
  }
}
