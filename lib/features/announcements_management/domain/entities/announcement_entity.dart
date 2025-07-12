class AnnouncementEntity {
  final String id;
  final String title;
  final String description;
  final List<String>? image;
  final String createdAt;

  AnnouncementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
  });
}
