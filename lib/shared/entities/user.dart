import 'role.dart';

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
  final int? numberOfMajorYears;
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
    this.numberOfMajorYears,
  });

  /// Convert role string to Role enum
  Role get roleEnum {
    switch (role.toLowerCase()) {
      case 'admin':
        return Role.admin;
      case 'professor':
        return Role.professor;
      case 'superadmin':
        return Role.superadmin;
      case 'systemcontroller':
        return Role.systemcontroller;
      default:
        return Role.unknown;
    }
  }

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
      'numberOfMajorYears': numberOfMajorYears,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    // Handle both nested and flat formats for firstName and lastName
    String getFirstNameAr() {
      if (map['firstName'] is Map) {
        return map['firstName']['ar'] as String;
      } else {
        return map['firstNameAr'] as String;
      }
    }

    String getFirstNameEn() {
      if (map['firstName'] is Map) {
        return map['firstName']['en'] as String;
      } else {
        return map['firstNameEn'] as String;
      }
    }

    String getLastNameAr() {
      if (map['lastName'] is Map) {
        return map['lastName']['ar'] as String;
      } else {
        return map['lastNameAr'] as String;
      }
    }

    String getLastNameEn() {
      if (map['lastName'] is Map) {
        return map['lastName']['en'] as String;
      } else {
        return map['lastNameEn'] as String;
      }
    }

    return User(
      firstNameAr: getFirstNameAr(),
      firstNameEn: getFirstNameEn(),
      lastNameAr: getLastNameAr(),
      lastNameEn: getLastNameEn(),
      fatherNameAr:
          map['fatherName']?['ar'] as String? ?? map['fatherNameAr'] as String?,
      fatherNameEn:
          map['fatherName']?['en'] as String? ?? map['fatherNameEn'] as String?,
      majorNameAr:
          map['majorName']?['ar'] as String? ?? map['majorNameAr'] as String?,
      majorNameEn:
          map['majorName']?['en'] as String? ?? map['majorNameEn'] as String?,
      facultyNameAr: map['facultyName']?['ar'] as String? ??
          map['facultyNameAr'] as String?,
      facultyNameEn: map['facultyName']?['en'] as String? ??
          map['facultyNameEn'] as String?,
      gmail: map['gmail'] as String,
      image: map['image'] as String? ?? '',
      role: map['role'] as String,
      numberOfMajorYears: map['numberOfYears'] as int?,
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
    // Handle both nested and flat formats for firstName and lastName
    String getFirstNameAr() {
      if (map['firstName'] is Map) {
        return map['firstName']['ar'] as String;
      } else {
        return map['firstNameAr'] as String;
      }
    }

    String getFirstNameEn() {
      if (map['firstName'] is Map) {
        return map['firstName']['en'] as String;
      } else {
        return map['firstNameEn'] as String;
      }
    }

    String getLastNameAr() {
      if (map['lastName'] is Map) {
        return map['lastName']['ar'] as String;
      } else {
        return map['lastNameAr'] as String;
      }
    }

    String getLastNameEn() {
      if (map['lastName'] is Map) {
        return map['lastName']['en'] as String;
      } else {
        return map['lastNameEn'] as String;
      }
    }

    return FullUser(
      firstNameAr: getFirstNameAr(),
      firstNameEn: getFirstNameEn(),
      lastNameAr: getLastNameAr(),
      lastNameEn: getLastNameEn(),
      gmail: map['gmail'] as String,
      majorNameAr:
          map['majorName']?['ar'] as String? ?? map['majorNameAr'] as String?,
      majorNameEn:
          map['majorName']?['en'] as String? ?? map['majorNameEn'] as String?,
      facultyNameAr: map['facultyName']?['ar'] as String? ??
          map['facultyNameAr'] as String?,
      facultyNameEn: map['facultyName']?['en'] as String? ??
          map['facultyNameEn'] as String?,
      fatherNameAr:
          map['fatherName']?['ar'] as String? ?? map['fatherNameAr'] as String?,
      fatherNameEn:
          map['fatherName']?['en'] as String? ?? map['fatherNameEn'] as String?,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
      deviceToken: map['deviceToken'] as String? ?? '',
      image: map['image'] as String? ?? '',
      role: map['role'] as String,
    );
  }
}
