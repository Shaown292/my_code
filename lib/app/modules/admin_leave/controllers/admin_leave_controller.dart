import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class AdminLeaveController extends GetxController {
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  void showPendingListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text("Reason: something}", style:  AppTextStyle.fontSize14BlackW500,),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void showApprovedListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text("Reason: something", style:  AppTextStyle.fontSize14BlackW500,),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void showRejectedListDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text("Reason: asdjas", style:  AppTextStyle.fontSize14BlackW500,),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Apply Date",
                value: "",
              ),
              const BottomSheetTile(
                title: "Leave From",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Leave To",
                value: "",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

}
