class Major {
  final String id;
  final String name;
  final int numberOfYears;
  Major({required this.id, required this.name, required this.numberOfYears});

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(
      id: map['id'],
      name: map['name'],
      numberOfYears: map['numberOfYears'] ?? 0,
    );
  }
}
