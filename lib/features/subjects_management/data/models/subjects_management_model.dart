class UniversitySubjects {
  final String universityName;
  final List<FacultySubjects> faculties;

  UniversitySubjects({required this.universityName, required this.faculties});

  factory UniversitySubjects.fromJson(Map<String, dynamic> json) {
    return UniversitySubjects(
      universityName: json['universityName'],
      faculties: (json['faculties'] as List<dynamic>)
          .map((e) => FacultySubjects.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'universityName': universityName,
        'faculties': faculties.map((e) => e.toJson()).toList(),
      };
}

class FacultySubjects {
  final String facultyName;
  final List<MajorSubjects> majors;

  FacultySubjects({required this.facultyName, required this.majors});

  factory FacultySubjects.fromJson(Map<String, dynamic> json) {
    return FacultySubjects(
      facultyName: json['facultyName'] ?? '',
      majors: (json['majors'] as List<dynamic>)
          .map((e) => MajorSubjects.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'facultyName': facultyName,
        'majors': majors.map((e) => e.toJson()).toList(),
      };
}

class MajorSubjects {
  final String majorName;
  final List<Subject> subjects;

  MajorSubjects({required this.majorName, required this.subjects});

  factory MajorSubjects.fromJson(Map<String, dynamic> json) {
    return MajorSubjects(
      majorName: json['majorName'],
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'majorName': majorName,
        'subjects': subjects.map((e) => e.toJson()).toList(),
      };
}

class Subject {
  final String id;
  final String name;
  final String description;
  final String majorId;
  final int year;
  final int semester;
  final double midtermGrade;
  final double finalGrade;
  final bool isLabRequired;
  final bool isMultipleChoice;
  final bool isOpenBook;
  final String image;
  final List<MaterialsUrl> materialUrls;

  Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.majorId,
    required this.year,
    required this.semester,
    required this.midtermGrade,
    required this.finalGrade,
    required this.isLabRequired,
    required this.isMultipleChoice,
    required this.isOpenBook,
    required this.image,
    required this.materialUrls,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      majorId: json['majorId'],
      year: json['year'],
      semester: json['semester'],
      midtermGrade: (json['midtermGrade'] as num).toDouble(),
      finalGrade: (json['finalGrade'] as num).toDouble(),
      isLabRequired: json['isLabRequired'],
      isMultipleChoice: json['isMultipleChoice'],
      isOpenBook: json['isOpenBook'],
      image: json['image'] ?? '',
      materialUrls: (json['materialUrls'] as List<dynamic>? ?? [])
          .map((e) => MaterialsUrl.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'majorId': majorId,
        'year': year,
        'semester': semester,
        'midtermGrade': midtermGrade,
        'finalGrade': finalGrade,
        'isLabRequired': isLabRequired,
        'isMultipleChoice': isMultipleChoice,
        'isOpenBook': isOpenBook,
        'image': image,
        'materialUrls': materialUrls,
      };
}

class MaterialsUrl {
  final String url;
  final MaterialsUrlType type;

  MaterialsUrl({required this.url, required this.type});

  factory MaterialsUrl.fromJson(Map<String, dynamic> json) {
    return MaterialsUrl(
      url: json['url'],
      type: MaterialsUrlType.values.firstWhere((e) => e.name == json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'type': type.name,
      };
}

enum MaterialsUrlType {
  pdf,
  image,
  video,
  audio,
  document,
  excel,
  word,
  powerpoint,
  zip,
  rar,
  other,
}

// New model for SuperAdmin API response
class SuperAdminSubjects {
  final List<MajorSubjects> majors;

  SuperAdminSubjects({required this.majors});

  factory SuperAdminSubjects.fromJson(Map<String, dynamic> json) {
    return SuperAdminSubjects(
      majors: (json['majors'] as List<dynamic>)
          .map((e) => MajorSubjects.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'majors': majors.map((e) => e.toJson()).toList(),
      };
}
