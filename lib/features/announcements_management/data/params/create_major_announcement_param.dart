class CreateMajorAnnouncementParam {
  final String subjectId;
  final String titleEn;
  final String titleAr;
  final String contentEn;
  final String contentAr;

  CreateMajorAnnouncementParam({
    required this.subjectId,
    required this.titleEn,
    required this.titleAr,
    required this.contentEn,
    required this.contentAr,
  });

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'titleEn': titleEn,
      'titleAr': titleAr,
      'contentEn': contentEn,
      'contentAr': contentAr,
    };
  }
} 