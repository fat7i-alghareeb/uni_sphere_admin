
class User {
  final String studentId;
  final String firstName;
  final String lastName;
  final String fatherName;
  final String enrollmentStatusName;
  final String majorName;
  final String studentNumber;
  final int year;
  final int numberOfMajorYears;
  final String image;
  User({
    required this.firstName,
    required this.studentId,
    required this.lastName,
    required this.fatherName,
    required this.enrollmentStatusName,
    required this.majorName,
    required this.studentNumber,
    required this.year,
    required this.numberOfMajorYears,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'enrollmentStatusName': enrollmentStatusName,
      'majorName': majorName,
      'studentNumber': studentNumber,
      'year': year,
      'fullName': '$firstName $lastName',
      'numberOfMajorYears': numberOfMajorYears,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      studentId: map['studentId'] as String? ?? map['id'] as String? ?? '',
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      fatherName: map['fatherName'] as String,
      enrollmentStatusName: map['enrollmentStatusName'] as String,
      majorName: map['majorName'] as String,
      studentNumber: map['studentNumber'] as String,
      year: map['year'] as int,
      numberOfMajorYears: map['numberOfMajorYears'] as int,
      image: map['image'] as String? ?? '',
    );
  }
}

class FullUser extends User {
  final String refreshToken;
  final String accessToken;
  final String deviceToken;

  FullUser({
    required super.firstName,
    required super.lastName,
    required super.studentId,
    required super.year,
    required super.majorName,
    required super.studentNumber,
    required super.enrollmentStatusName,
    required super.fatherName,
    required this.refreshToken,
    required this.accessToken,
    required this.deviceToken,
    required super.numberOfMajorYears,
    required super.image,
  });

  factory FullUser.fromMap(Map<String, dynamic> map) {
    return FullUser(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      studentId: map['studentId'] as String,
      year: map['year'] as int,
      majorName: map['majorName'] as String,
      studentNumber: map['studentNumber'] as String,
      enrollmentStatusName: map['enrollmentStatusName'] as String,
      fatherName: map['fatherName'] as String,
      refreshToken: map['refreshToken'] as String,
      accessToken: map['accessToken'] as String,
      deviceToken: map['deviceToken'] as String? ?? '',
      numberOfMajorYears: map['numberOfMajorYears'] as int? ?? 0,
      image: map['image'] as String? ?? '',
    );
  }
}
