import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'custom_tab_bar_item.dart';

class PageWidget extends StatelessWidget {
  final ProfileController controller;

  const PageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => CustomTabBarItem(
              title: 'Personal',
              isActive: controller.pageIndex.value == 0 ? true : false,
              onTap: () {
                print(controller.pageIndex.value == 0 ? true : false);
                controller.pageIndex.value = 0;
                controller.profilePageController.jumpToPage(0);
              },
            )),
        Obx(
          () => CustomTabBarItem(
            title: 'Parents',
            isActive: controller.pageIndex.value == 1 ? true : false,
            onTap: () {
              print(controller.pageIndex.value == 1 ? true : false);
              controller.pageIndex.value = 1;
              controller.profilePageController.jumpToPage(1);
            },
          ),
        ),
        Obx(
          () => CustomTabBarItem(
            title: 'Transport',
            isActive: controller.pageIndex.value == 2 ? true : false,
            onTap: () {
              print(controller.pageIndex.value == 2 ? true : false);
              controller.pageIndex.value = 2;
              controller.profilePageController.jumpToPage(2);
            },
          ),
        ),
      ],
    );
  }
}
