class AppUrl {
  static String getAllSubjects = '';

  static String getSubjectById = '';

  static const baseUrlDevelopment = 'http://194.32.76.82:8799/';

  static const _mobile = "Mobile";

  //************** Student ***************/
  static const _student = "$_mobile/Student";
  static const login = '$_student/LogIn';
  static const resetPassword = '$_student/ResetPassword';
  static const refreshToken = '$_student/RefreshToken';
  static const createAccount = '$_student/Create';

  static const getProfile = '';
  static const modifyProfile = '';
  static const getMyProfile = '';
  static const getAllNotification = '';

  static const contactUs = '';

  static const forgetPassword = '';

  static const confirmForgetPassword = '';
  AppUrl._();
}
