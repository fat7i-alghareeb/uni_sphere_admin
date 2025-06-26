
class User {
  final String studentId;
  final String firstNameAr;
  final String firstNameEn;
  final String lastNameAr;
  final String lastNameEn;
  final String fatherNameAr;
  final String fatherNameEn;
  final String enrollmentStatusNameAr;
  final String enrollmentStatusNameEn;
  final String majorNameAr;
  final String majorNameEn;
  final String gmail;
  final String image;
  final String role;
  User({
    required this.studentId,
    required this.firstNameAr,
    required this.firstNameEn,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.fatherNameAr,
    required this.fatherNameEn,
    required this.enrollmentStatusNameAr,
    required this.enrollmentStatusNameEn,
    required this.majorNameAr,
    required this.majorNameEn,
    required this.gmail,
    required this.image,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'firstNameAr': firstNameAr,
      'firstNameEn': firstNameEn,
      'lastNameAr': lastNameAr,
      'lastNameEn': lastNameEn,
      'fatherNameAr': fatherNameAr,
      'fatherNameEn': fatherNameEn,
      'enrollmentStatusNameAr': enrollmentStatusNameAr,
      'enrollmentStatusNameEn': enrollmentStatusNameEn,
      'majorNameAr': majorNameAr,
      'majorNameEn': majorNameEn,
      'gmail': gmail,
      'image': image,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    
    return User(
      studentId: map['studentId'] as String? ?? map['id'] as String? ?? '',
      firstNameAr: map['firstName']['ar'] as String,
      firstNameEn: map['firstName']['en'] as String,
      lastNameAr: map['lastName']['ar'] as String,
      lastNameEn: map['lastName']['en'] as String,
      fatherNameAr: map['fatherName']['ar'] as String,
      fatherNameEn: map['fatherName']['en'] as String,
      enrollmentStatusNameAr: map['enrollmentStatusName']['ar'] as String,
      enrollmentStatusNameEn: map['enrollmentStatusName']['en'] as String,
      majorNameAr: map['majorName']['ar'] as String,
      majorNameEn: map['majorName']['en'] as String,
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
    required super.studentId,
    required super.gmail,
    required super.majorNameAr,
    required super.majorNameEn,
    required super.enrollmentStatusNameAr,
    required super.enrollmentStatusNameEn,
    required super.fatherNameAr,
    required super.fatherNameEn,
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
      studentId: map['studentId'] as String,
      gmail: map['gmail'] as String,
      majorNameAr: map['majorName']['ar'] as String,
      majorNameEn: map['majorName']['en'] as String,
      enrollmentStatusNameAr: map['enrollmentStatusName']['ar'] as String,
      enrollmentStatusNameEn: map['enrollmentStatusName']['en'] as String,
      fatherNameAr: map['fatherName']['ar'] as String,
      fatherNameEn: map['fatherName']['en'] as String,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
      deviceToken: map['deviceToken'] as String? ?? '',
      image: map['image'] as String? ?? '',
      role: map['role'] as String,
    );
  }
}
