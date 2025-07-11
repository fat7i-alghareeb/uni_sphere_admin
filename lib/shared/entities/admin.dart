class Admin {
  final String id;
  final String name;
  Admin({required this.id, required this.name});

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
    );
  }
}
