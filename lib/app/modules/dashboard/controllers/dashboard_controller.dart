import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';


class DashboardController extends GetxController {
  final PersistentTabController tabIndexController =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> tabItem = [

    navItem(icon :FontAwesomeIcons.house, title:'Home'),
    navItem(icon :FontAwesomeIcons.bell, title:'Notification', isNotification: true),

    PersistentBottomNavBarItem(
      inactiveIcon: GlobalVariableController.roleId == 4
          ? Image.asset(
              ImagePath.studentWallet,
              width: 25,
              height: 25,
              color: Colors.white,
            )
          : Image.asset(
              ImagePath.studentWallet,
              width: 25,
              height: 25,
              color: Colors.white,
            ),
      icon: GlobalVariableController.roleId == 2
          ? Image.asset(
              ImagePath.studentWallet,
              width: 25,
              height: 25,
              color: Colors.white,
            )
          : Image.asset(
              ImagePath.studentWallet,
              width: 25,
              height: 25,
              color: Colors.white,
            ),
      title: GlobalVariableController.roleId == 4 ? "Attendance" : "Fees",
      activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
      inactiveColorPrimary: Colors.grey.withOpacity(0.9),
    ),
    navItem(icon : FontAwesomeIcons.stubber, title:  'Routine'),
    navItem(icon : FontAwesomeIcons.person, title: 'Profile'),
  ];
}

PersistentBottomNavBarItem navItem({required IconData icon, title,bool isNotification = false}) {
  return PersistentBottomNavBarItem(
    inactiveIcon: isNotification ? const NotificationBell() : Icon(
      icon,
      size: 18,
    ),

    icon: isNotification ? const NotificationBell() :  Icon(
      icon,
      size: 18,
    ),
    title: title,
    activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
    inactiveColorPrimary: Colors.grey.withOpacity(0.9),
  );
}


class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset("assets/svg/student/notification_bell.svg",),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            height: 20,
            width: 20,
            decoration:  const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child:  Center(
              child: Text(
                GlobalVariableController.notificationCount.toString(),
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ],

    );
  }
}

// Widget notificationBell(){
//
//   return  Stack(
//
//     children: [
//        const Positioned(
//         top: 5,
//           right: 5,
//           child: Center(child: Text("12",style: AppTextStyle.cardTextStyle14PurpleW500,))
//       ),
//       SvgPicture.asset("assets/svg/student/notification_bell.svg"),
//     ],
//
//   );
// }






// PersistentBottomNavBarItem(
//   inactiveIcon: const Icon(
//     FontAwesomeIcons.house,
//     size: 18,
//   ),
//   icon: const Icon(
//     FontAwesomeIcons.house,
//     size: 18,
//   ),
//   title: "Home".tr,
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),
// PersistentBottomNavBarItem(
//   inactiveIcon: const Icon(
//     FontAwesomeIcons.bell,
//     size: 18,
//   ),
//   icon: const Icon(
//     FontAwesomeIcons.bell,
//     size: 18,
//   ),
//   title: "Notification".tr,
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),
// PersistentBottomNavBarItem(
//   inactiveIcon: GlobalVariableController.roleId == 4
//       ? Image.asset(
//     ImagePath.studentWallet,
//     width: 25,
//     height: 25,
//     color: Colors.white,
//   )
//       : Image.asset(
//     ImagePath.studentWallet,
//     width: 25,
//     height: 25,
//     color: Colors.white,
//   ),
//   icon: GlobalVariableController.roleId == 2
//       ? Image.asset(
//     ImagePath.studentWallet,
//     width: 25,
//     height: 25,
//     color: Colors.white,
//   )
//       : Image.asset(
//     ImagePath.studentWallet,
//     width: 25,
//     height: 25,
//     color: Colors.white,
//   ),
//   title: GlobalVariableController.roleId == 4 ? "Attendance" : "Fees",
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),
// PersistentBottomNavBarItem(
//   inactiveIcon: const Icon(
//     FontAwesomeIcons.stubber,
//     size: 18,
//   ),
//   icon: const Icon(
//     FontAwesomeIcons.stubber,
//     size: 18,
//   ),
//   title: "Routine",
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),
// PersistentBottomNavBarItem(
//   inactiveIcon: const Icon(
//     FontAwesomeIcons.person,
//     size: 18,
//   ),
//   icon: const Icon(
//     FontAwesomeIcons.person,
//     size: 18,
//   ),
//   title: "Profile",
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),
// PersistentBottomNavBarItem(
//   inactiveIcon: badges.Badge(
//     badgeContent: Text(
//       '0',
//       style: TextStyle(color: Colors.black),
//     ),
//     badgeStyle: badges.BadgeStyle(
//       badgeColor: Colors.deepPurple.withOpacity(0.8),
//     ),
//     badgeAnimation: const badges.BadgeAnimation.fade(
//       animationDuration: Duration(seconds: 1),
//       loopAnimation: false,
//     ),
//     child: Icon(
//       Themify.bell,
//       size: 22,
//       color: Colors.grey.withOpacity(0.9),
//     ),
//   ),
//   icon: badges.Badge(
//     badgeContent: Text(
//       '0',
//       style: TextStyle(color: Colors.black),
//     ),
//     badgeStyle: badges.BadgeStyle(
//       badgeColor: Colors.deepPurple.withOpacity(0.8),
//     ),
//     badgeAnimation: const badges.BadgeAnimation.fade(
//       animationDuration: Duration(seconds: 1),
//       loopAnimation: false,
//     ),
//     child: Icon(
//       Themify.bell,
//       size: 22,
//       color: Colors.grey.withOpacity(0.9),
//     ),
//   ),
//   title: "Notification".tr,
//   activeColorPrimary: Colors.deepPurple.withOpacity(0.9),
//   inactiveColorPrimary: Colors.grey.withOpacity(0.9),
// ),

//.........................

// badges.Badge(
//   badgeContent: Text('3'),
//   child: Icon(Icons.settings),
// ),

// Stack(
//   children: [
//     Icon(
//       icon,
//       size: 30,
//     ),
//     Positioned(
//       right: 0,
//       child: Container(
//         height: 18,
//         width: 18,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           color: Colors.purple,
//         ),
//         child: const Center(
//           child: DefaultTextStyle(
//             style: TextStyle(fontSize: 10, color: Colors.black),
//             child: Text('0'),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),