class AppUrl {
  static const baseUrlDevelopment = 'https://192.168.1.43:5001';

  static const _auth = "/Auth";
  static const _api = "/api";
  static const _admin = "/Admin";
  static const _superAdmin = "/SuperAdmin";
  static const _professor = "/Professors";
  static const _systemController = "/SystemController";
  // static const _student = "Student";

  //! ************** Auth *************** //
  static const loginAdmin = '$_api/$_admin/$_auth/Login';
  static const registerAdmin = '$_api/$_admin/$_auth/Register';
  static const checkOneTimeCodeAdmin = '$_api/$_admin/$_auth/CheckOneTimeCode';
  static const loginSuperAdmin = '$_api/$_superAdmin/$_auth/Login';
  static const registerSuperAdmin = '$_api/$_superAdmin/$_auth/Register';
  static const checkOneTimeCodeSuperAdmin =
      '$_api/$_superAdmin/$_auth/CheckOneTimeCode';
  static const loginProfessor = '$_api/$_professor/$_auth/Login';
  static const registerProfessor = '$_api/$_professor/$_auth/Register';
  static const checkOneTimeCodeProfessor =
      '$_api/$_professor/$_auth/CheckOneTimeCode';
  static const loginSystemController = '$_api/$_systemController/$_auth/Login';

  static const refreshToken = '$_api/$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//

  //! ************** Subject Management *************** //
  static const _subject = "/api/Subject";
  static const viewSuperAdminSubjects = "$_subject/$_superAdmin/MySubjects";
  static const viewProfessorSubjects = "$_subject/$_professor/MySubjects";
  static const uploadMaterials = "$_subject/$_professor/UploadMaterials";
  static const getSuperAdminSubjects = "$_subject/$_superAdmin/Subjects";
  static const getProfessorSubjects = "$_subject/Professor/Subjects";
  static String getSuperAdminSubjectById(String id) =>
      "$_subject/$_superAdmin/$id";
  static String getProfessorSubjectById(String id) =>
      "$_subject/$_professor/$id";
  static String updateSubject(String id) => '$_subject/$id';
  static String uploadMaterial(String id) => '$_subject/$id/materials';
  static String editSubject(String id) => '$_subject/$id';
  //! ************** End Subject Management *************** //

  //! ************** Student Management *************** //
  static const addStudent = "/api/Student/AddStudent";
  //! ************** End Student Management *************** //
  //! ************** news Management *************** //
  static const _announcements = "/api/Announcements";
  static const createFacultyAnnouncement =
      "$_announcements/CreateFacultyAnnouncement";
  static const createMajorAnnouncement =
      "$_announcements/CreateMajorAnnouncement";

  //! ************** End news Management *************** //

  //! ************** Generate one time code *************** //
  static const assignOneTimeCode = "$_superAdmin/AssignOneTimeCode";
  //! ************** End Generate one time code *************** //

  //! ************** Super Admin *************** //
  static const addProfessorToFaculty = "$_professor/AddProfessorToFaculty";
  static const removeProfessorFromFaculty =
      "$_professor/RemoveProfessorFromFaculty";
  static const assignProfessorToSubject =
      "$_professor/AssignProfessorToSubject";
  static const removeProfessorFromSubject =
      "$_professor/RemoveProfessorFromSubject";
  //! ************** End Super Admin *************** //

  //! ************** Info ***************//
  static const _info = "/api/Info";
  static const getFaculties = '$_info/GetFaculties';
  static const getMajors = '$_info/GetMajors';
  static const getSuperAdminMajors = '$_info/SuperAdmin/GetMyFacultyMajors';
  static const getHomePageInfo = '$_info/GetHomePageInfo';
  static const getMyMajorSubjects = '$_info/$_admin/MyMajorSubjects';

  //! ************** Ent Info ***************//
  //! ************** Schedule Management *************** //
  static const _schedule = "/api/Schedule";
  static const _scheduleManagement = "/api/ScheduleManagement";
  static const addLecture = "$_scheduleManagement/AddLecture";
  static const createSchedule = "$_scheduleManagement/CreateSchedule";
  static String deleteLecture(String id) => "$_scheduleManagement/$id";
  static String updateSchedule(String id) => "$_schedule/$id";
  static const getScheduleByMonth = "$_schedule/$_admin/GetScheduleByMonth";
  static const getMySchedule =
      "$_scheduleManagement/UpdateLecture/GetMySchedule";
  //! ************** End Schedule Management *************** //

  //! ************** Subject Grade Management *************** //
  static const _subjectGrade = "/api/Grades";
  static const assignGradesToSubject = "$_subjectGrade/AssignGradesToSubject";
  //! ************** End Subject Grade Management *************** //
  //! ************** AssignOneTimeCode ***************//
  static const assignOneTimeCodeToStudent =
      "$_admin/AssignOneTimeCodeToStudent";
  static const assignOneTimeCodeToProfessor = "$_superAdmin/AssignOneTimeCode";
  //! ************** End AssignOneTimeCode ***************//

  AppUrl._();
}
