class MaterialsManagementEntity {
  final String id;
  final String subjectId;
  final String title;
  final String fileUrl;
  final String? category;
  MaterialsManagementEntity({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.fileUrl,
    this.category,
  });
}
