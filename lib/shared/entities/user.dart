class User {
  final String firstNameAr;
  final String firstNameEn;
  final String lastNameAr;
  final String lastNameEn;
  String? fatherNameAr;
  String? fatherNameEn;
  final String? majorNameAr;
  final String? majorNameEn;
  final String? facultyNameAr;
  final String? facultyNameEn;
  final String gmail;
  final String image;
  final String role;
  User({
    required this.firstNameAr,
    required this.firstNameEn,
    required this.lastNameAr,
    required this.lastNameEn,
    this.fatherNameAr,
    this.fatherNameEn,
    this.majorNameAr,
    this.majorNameEn,
    this.facultyNameAr,
    this.facultyNameEn,
    required this.gmail,
    required this.image,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstNameAr': firstNameAr,
      'firstNameEn': firstNameEn,
      'lastNameAr': lastNameAr,
      'lastNameEn': lastNameEn,
      'fatherNameAr': fatherNameAr,
      'fatherNameEn': fatherNameEn,
      'majorNameAr': majorNameAr,
      'majorNameEn': majorNameEn,
      'facultyNameAr': facultyNameAr,
      'facultyNameEn': facultyNameEn,
      'gmail': gmail,
      'image': image,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstNameAr: map['firstName']['ar'] as String,
      firstNameEn: map['firstName']['en'] as String,
      lastNameAr: map['lastName']['ar'] as String,
      lastNameEn: map['lastName']['en'] as String,
      fatherNameAr: map['fatherName']?['ar'] as String?,
      fatherNameEn: map['fatherName']?['en'] as String?,
      majorNameAr: map['majorName']?['ar'] as String?,
      majorNameEn: map['majorName']?['en'] as String?,
      facultyNameAr: map['facultyName']?['ar'] as String?,
      facultyNameEn: map['facultyName']?['en'] as String?,
      gmail: map['gmail'] as String,
      image: map['image'] as String? ?? '',
      role: map['role'] as String,
    );
  }
}

class FullUser extends User {
  final String refreshToken;
  final String accessToken;
  final String deviceToken;

  FullUser({
    required super.firstNameAr,
    required super.firstNameEn,
    required super.lastNameAr,
    required super.lastNameEn,
    required super.gmail,
    super.majorNameAr,
    super.majorNameEn,
    super.facultyNameAr,
    super.facultyNameEn,
    super.fatherNameAr,
    super.fatherNameEn,
    required this.refreshToken,
    required this.accessToken,
    required this.deviceToken,
    required super.image,
    required super.role,
  });

  factory FullUser.fromMap(Map<String, dynamic> map) {
    return FullUser(
      firstNameAr: map['firstName']['ar'] as String,
      firstNameEn: map['firstName']['en'] as String,
      lastNameAr: map['lastName']['ar'] as String,
      lastNameEn: map['lastName']['en'] as String,
      gmail: map['gmail'] as String,
      majorNameAr: map['majorName']?['ar'] as String?,
      majorNameEn: map['majorName']?['en'] as String?,
      facultyNameAr: map['facultyName']?['ar'] as String?,
      facultyNameEn: map['facultyName']?['en'] as String?,
      fatherNameAr: map['fatherName']?['ar'] as String?,
      fatherNameEn: map['fatherName']?['en'] as String?,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
      deviceToken: map['deviceToken'] as String? ?? '',
      image: map['image'] as String? ?? '',
      role: map['role'] as String,
    );
  }
}
