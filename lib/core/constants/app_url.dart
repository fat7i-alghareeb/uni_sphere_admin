class AppUrl {
  static String getAllSubjects = '';

  static String getSubjectById = '';

  static const baseUrlDevelopment = 'https://192.168.102.173:5001/';

  static const _auth = "Auth";
  //! ************** Auth *************** //
  static const _student = "$_auth/Student";
  static const login = '$_student/Login';
  static const register = '$_student/Register';
  static const checkOneTimeCode = '$_student/CheckOneTimeCode';
  // static const resetPassword = '$_student/ResetPassword';
  static const refreshToken = '$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//
  AppUrl._();
}
