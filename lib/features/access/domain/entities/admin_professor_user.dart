class AdminProfessorUser {
  final String id;
  final String email;
  final String password;
  final String role; // 'admin' or 'professor'
  AdminProfessorUser({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
  });
}
