import 'dart:io';

class CreateFacultyAnnouncementParam {
  final String titleEn;
  final String titleAr;
  final String contentEn;
  final String contentAr;
  final List<File> images;

  CreateFacultyAnnouncementParam({
    required this.titleEn,
    required this.titleAr,
    required this.contentEn,
    required this.contentAr,
    required this.images,
  });

  Map<String, dynamic> toFormData() {
    final Map<String, dynamic> formData = {
      'titleEn': titleEn,
      'titleAr': titleAr,
      'contentEn': contentEn,
      'contentAr': contentAr,
    };

    // Add images to form data
    for (int i = 0; i < images.length; i++) {
      formData['images[$i]'] = images[i];
    }

    return formData;
  }
}
