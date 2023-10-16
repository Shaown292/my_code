import 'package:flutter_single_getx_api_v2/app/modules/notification/binding/notification_binding.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/view/notification_view.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/bindings/profile_bindings.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/profile_view.dart';
import 'package:flutter_single_getx_api_v2/app/modules/syllabus/bindings/syllabus_bindings.dart';
import 'package:flutter_single_getx_api_v2/app/modules/syllabus/views/syllabus_views.dart';

import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_bindings.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/secondary_splash/bindings/secondary_splash_binding.dart';
import '../modules/secondary_splash/views/secondary_splash_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
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
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      bindings: [
        DashboardBinding(),
        ProfileBinding(),
        HomeBinding(),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
