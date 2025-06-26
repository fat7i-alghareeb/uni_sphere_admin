class AppUrl {
  static String getAllSubjects = '';

  static String getSubjectById = '';

  static const baseUrlDevelopment = 'https://192.168.102.173:5001/';

  static const _auth = "Auth";
  static const _admin = "Admin";
  static const _superAdmin = "SuperAdmin";
  static const _professor = "Professor";
  static const _systemController = "SystemController";
  // static const _student = "Student";

  //! ************** Auth *************** //
  static const loginAdmin = '$_admin/Login';
  static const registerAdmin = '$_admin/Register';
  static const checkOneTimeCodeAdmin = '$_admin/CheckOneTimeCode';
  static const loginSuperAdmin = '$_superAdmin/Login';
  static const registerSuperAdmin = '$_superAdmin/Register';
  static const checkOneTimeCodeSuperAdmin = '$_superAdmin/CheckOneTimeCode';
  static const loginProfessor = '$_professor/Login';
  static const registerProfessor = '$_professor/Register';
  static const checkOneTimeCodeProfessor = '$_professor/CheckOneTimeCode';
  static const loginSystemController = '$_systemController/Login';

  static const refreshToken = '$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//

  //! ************** Subject Management *************** //
  static const _subject = "Subject";
  static const viewSuperAdminSubjects = "$_subject/$_superAdmin/MySubjects";
  static const viewProfessorSubjects = "$_subject/$_professor/MySubjects";
  static const uploadMaterials = "$_subject/$_professor/UploadMaterials";

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
  //! ************** Schedule *************** //
  static const _scheduleManagement = "ScheduleManagement";
  static const addLecture = "$_scheduleManagement/AddLecture";
  static String deleteLecture(String id) => "$_scheduleManagement/$id";

  //! ************** End Schedule *************** //

  AppUrl._();
}
