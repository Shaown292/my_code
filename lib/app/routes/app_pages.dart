import 'package:get/get.dart';

import '../modules/active_exam/bindings/active_exam_binding.dart';
import '../modules/active_exam/views/active_exam_view.dart';
import '../modules/apply_leave/bindings/apply_leave_binding.dart';
import '../modules/apply_leave/views/apply_leave_view.dart';
import '../modules/assignment/bindings/assignment_binding.dart';
import '../modules/assignment/views/assignment_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dormitory/bindings/dormitory_binding.dart';
import '../modules/dormitory/views/dormitory_view.dart';
import '../modules/exam_result/bindings/exam_result_binding.dart';
import '../modules/exam_result/views/exam_result_view.dart';
import '../modules/examination/bindings/examination_binding.dart';
import '../modules/examination/views/examination_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leave/bindings/leave_binding.dart';
import '../modules/leave/views/leave_view.dart';
import '../modules/leave_list/bindings/leave_list_binding.dart';
import '../modules/leave_list/views/leave_list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/view/notification_view.dart';
import '../modules/online_exam/bindings/online_exam_binding.dart';
import '../modules/online_exam/views/online_exam_view.dart';
import '../modules/other_downloads/bindings/other_downloads_binding.dart';
import '../modules/other_downloads/views/other_downloads_view.dart';
import '../modules/profile/bindings/profile_bindings.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_edit/bindings/profile_edit_binding.dart';
import '../modules/profile_edit/views/profile_edit_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/routine/bindings/routine_binding.dart';
import '../modules/routine/views/routine_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/secondary_splash/bindings/secondary_splash_binding.dart';
import '../modules/secondary_splash/views/secondary_splash_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/student_homework/bindings/student_homework_binding.dart';
import '../modules/student_homework/views/student_homework_view.dart';
import '../modules/study_materials/bindings/study_materials_binding.dart';
import '../modules/study_materials/views/study_materials_view.dart';
import '../modules/syllabus/bindings/syllabus_bindings.dart';
import '../modules/syllabus/views/syllabus_views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SECONDARY_SPLASH,
      page: () => const SecondarySplashView(),
      binding: SecondarySplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
        name: _Paths.SYLLABUS,
        page: () => const SyllabusView(),
        binding: SyllabusBinding(),
        transition: Transition.fade),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      bindings: [
        DashboardBinding(),
        ProfileBinding(),
        HomeBinding(),
        NotificationBinding(),
        RoutineBinding(),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_HOMEWORK,
      page: () => const StudentHomeworkView(),
      binding: StudentHomeworkBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ROUTINE,
      page: () => const RoutineView(),
      binding: RoutineBinding(),
    ),
    GetPage(
      name: _Paths.STUDY_MATERIALS,
      page: () => const StudyMaterialsView(),
      binding: StudyMaterialsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ASSIGNMENT,
      page: () => const AssignmentView(),
      binding: AssignmentBinding(),
      transition: Transition.fade,
    ),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => const SettingsView(),
        binding: SettingsBinding(),
        transition: Transition.fade),
    GetPage(
        name: _Paths.SCHEDULE,
        page: () => const ScheduleView(),
        binding: ScheduleBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
        name: _Paths.RESULT,
        page: () => const ResultView(),
        binding: ResultBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ACTIVE_EXAM,
        page: () => const ActiveExamView(),
        binding: ActiveExamBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.EXAMINATION,
      page: () => const ExaminationView(),
      binding: ExaminationBinding(),
      transition: Transition.fade,
    ),
    GetPage(
        name: _Paths.ONLINE_EXAM,
        page: () => const OnlineExamView(),
        binding: OnlineExamBinding(),
        transition: Transition.fade),
    GetPage(
        name: _Paths.EXAM_RESULT,
        page: () => const ExamResultView(),
        binding: ExamResultBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.OTHER_DOWNLOADS,
      page: () => const OtherDownloadsView(),
      binding: OtherDownloadsBinding(),
    ),
    GetPage(
      name: _Paths.DORMITORY,
      page: () => const DormitoryView(),
      binding: DormitoryBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_LEAVE,
      page: () => const ApplyLeaveView(),
      binding: ApplyLeaveBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_LIST,
      page: () => const LeaveListView(),
      binding: LeaveListBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE,
      page: () => const LeaveView(),
      binding: LeaveBinding(),
    ),
  ];
}
