import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/home_view.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/profile_view.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../notification/views/notification_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabIndexController,
      screens: [
        GlobalVariableController.roleId == 3
            ? const ProfileView()
            : const HomeView(),

        const NotificationView(),
        GlobalVariableController.roleId == 4
            ? const ProfileView()
            : const HomeView(),

        GlobalVariableController.roleId == 4
            ? const ProfileView()
            : const HomeView(),

        GlobalVariableController.roleId == 4
            ? const ProfileView()
            : const ProfileView(),
      ],
      items: controller.tabItem,
      hideNavigationBar: false,
      navBarHeight: 70,
      margin: const EdgeInsets.all(0),
      padding: const NavBarPadding.symmetric(horizontal: 5),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      // onItemSelected: (index) async {
      //   if (index == 1) {
      //     // await controller.getNotifications();
      //   }
      // },
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            offset: Offset(2, 3),
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
