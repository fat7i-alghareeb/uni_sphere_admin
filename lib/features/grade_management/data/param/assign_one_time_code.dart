enum TargetRole {
  admin,
  professor,
  student,
}

class AssignOneTimeCode {
  final TargetRole targetRole;
  final String? adminId;
  final String? professorId;
  final String? studentId;
  final int oneTimeCode;
  // final int expirationInMinutes;

  AssignOneTimeCode({
    required this.targetRole,
    this.adminId,
    this.professorId,
    this.studentId,
    required this.oneTimeCode,
    //  required this.expirationInMinutes,
  });

  factory AssignOneTimeCode.fromJson(Map<String, dynamic> json) {
    return AssignOneTimeCode(
      targetRole: TargetRole.values[json['targetRole']],
      adminId: json['adminId'],
      professorId: json['professorId'],
      studentId: json['studentId'],
      oneTimeCode: json['oneTimeCode'],
      //  expirationInMinutes: json['expirationInMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetRole': targetRole.index, // convert enum to int
      if (adminId != null) 'adminId': adminId,
      if (professorId != null) 'professorId': professorId,
      if (studentId != null) 'studentId': studentId,
      'oneTimeCode': oneTimeCode,
      //   'expirationInMinutes': expirationInMinutes,
    };
  }
}
