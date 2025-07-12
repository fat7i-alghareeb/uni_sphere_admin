import '../../domain/entities/announcement_entity.dart';

class AnnouncementModel extends AnnouncementEntity {
  AnnouncementModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.createdAt,
  });

  // For Admin API response
  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      id: map['announcementId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: null, // Admin API doesn't return images
      createdAt: map['createdAt'] ?? '',
    );
  }

  // For SuperAdmin API response
  factory AnnouncementModel.fromSuperAdminMap(Map<String, dynamic> map) {
    List<String>? images;
    if (map['images'] != null) {
      final imagesData = map['images'] as List;
      images = [];
      for (var image in imagesData) {
        if (image is String) {
          // If images is a list of strings
          images.add(image);
        } else if (image is Map<String, dynamic> && image['url'] != null) {
          // If images is a list of objects with url property
          images.add(image['url'] as String);
        }
      }
    }

    return AnnouncementModel(
      id: map['announcementId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: images,
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'announcementId': id,
      'title': title,
      'description': description,
      'images': image?.map((url) => {'url': url}).toList() ?? [],
      'createdAt': createdAt,
    };
  }
}
