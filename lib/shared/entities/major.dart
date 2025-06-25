class Major {
  final String id;
  final String name;

  Major({required this.id, required this.name});

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(id: map['id'], name: map['name']);
  }
}
