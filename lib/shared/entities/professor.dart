class Professor {
  final String id;
  final String name;
  Professor({required this.id, required this.name});

  factory Professor.fromMap(Map<String, dynamic> map) {
    return Professor(
      id: map['id'],
      name: map['name'],
    );
  }
}
