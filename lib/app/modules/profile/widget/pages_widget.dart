

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/widget/page_indicator.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';

class PageWidget extends StatelessWidget {
  final ProfileController controller ;
  const PageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [


        InkWell(
          child: Column(
            children: [
              const Text(
                "Personal",
                style: TextStyle(
                    color: AppColors
                        .profileCardBackgroundColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
              Obx(() => PageIndicator(isActive: controller.pageIndex.value == 0 ? true : false)),
            ],
          ),
          onTap: (){
            controller.pageIndex.value = 0;
            controller.profilePageController.jumpToPage(0);
          },
        ),

        InkWell(
          child:  Column(
            children: [
              const Text(
                "Parents",
                style: TextStyle(
                    color: AppColors
                        .profileCardBackgroundColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
              Obx(() => PageIndicator(isActive: controller.pageIndex.value == 1 ? true : false)),
            ],
          ),
          onTap: (){
            controller.pageIndex.value = 1;
            controller.profilePageController.jumpToPage(1);
          },
        ),

        InkWell(
          child: Column(
            children: [
              const Text(
                "Transport",
                style: TextStyle(
                    color: AppColors
                        .profileCardBackgroundColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
              Obx(() => PageIndicator(isActive: controller.pageIndex.value == 2 ? true : false))
            ],
          ),
          onTap: (){
            controller.pageIndex.value = 2;
            controller.profilePageController.jumpToPage(2);
          },
        ),

      ],
    );
  }
}
