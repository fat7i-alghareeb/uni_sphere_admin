class AppUrl {
  static const baseUrlDevelopment = 'https://192.168.1.125:5001/';

  static const _auth = "Auth";
  static const _admin = "Admin";
  static const _superAdmin = "SuperAdmin";
  static const _professor = "Professors";
  static const _systemController = "SystemController";
  // static const _student = "Student";

  //! ************** Auth *************** //
  static const loginAdmin = '$_admin/$_auth/Login';
  static const registerAdmin = '$_admin/$_auth/Register';
  static const checkOneTimeCodeAdmin = '$_admin/$_auth/CheckOneTimeCode';
  static const loginSuperAdmin = '$_superAdmin/$_auth/Login';
  static const registerSuperAdmin = '$_superAdmin/$_auth/Register';
  static const checkOneTimeCodeSuperAdmin =
      '$_superAdmin/$_auth/CheckOneTimeCode';
  static const loginProfessor = '$_professor/$_auth/Login';
  static const registerProfessor = '$_professor/$_auth/Register';
  static const checkOneTimeCodeProfessor =
      '$_professor/$_auth/CheckOneTimeCode';
  static const loginSystemController = '$_systemController/$_auth/Login';

  static const refreshToken = '$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//

  //! ************** Subject Management *************** //
  static const _subject = "Subject";
  static const viewSuperAdminSubjects = "$_subject/$_superAdmin/MySubjects";
  static const viewProfessorSubjects = "$_subject/$_professor/MySubjects";
  static const uploadMaterials = "$_subject/$_professor/UploadMaterials";
  static const getSuperAdminSubjects = "$_subject/$_superAdmin/Subjects";
  static const getProfessorSubjects = "$_subject/$_professor/Subjects";
  static String getSuperAdminSubjectById(String id) =>
      "$_subject/$_superAdmin/$id";
  static String getProfessorSubjectById(String id) =>
      "$_subject/$_professor/$id";
  static String updateSubject(String id) => '$_subject/$id';
  static String uploadMaterial(String id) => '$_subject/$id/materials';
  static String editSubject(String id) => '$_subject/$id';
  //! ************** End Subject Management *************** //

  //! ************** Student Management *************** //
  static const addStudent = "Student/AddStudent";
  //! ************** End Student Management *************** //
  //! ************** news Management *************** //
  static const _announcements = "Announcements";
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
  static const _info = "Info";
  static const getFaculties = '$_info/GetFaculties';
  static const getMajors = '$_info/GetMajors';
  static const getHomePageInfo = '$_info/GetHomePageInfo';
  
  //! ************** Ent Info ***************//
  //! ************** Schedule Management *************** //
  static const _schedule = "Schedule";
  static const _scheduleManagement = "ScheduleManagement";
  static const addLecture = "$_scheduleManagement/AddLecture";
  static const createSchedule = "$_scheduleManagement/CreateSchedule";
  static String deleteLecture(String id) => "$_scheduleManagement/$id";
  static String updateSchedule(String id) => "$_schedule/$id";
  static const getScheduleByMonth = "$_schedule/GetScheduleByMonth";
  static const getMySchedule = "$_schedule/GetMySchedule";
  //! ************** End Schedule Management *************** //
  AppUrl._();
}
