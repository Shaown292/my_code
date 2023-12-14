import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class FeesController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  RxInt recordId = 0.obs;
  final selectIndex = RxInt(0);

  void showFeesDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason:",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
              ),
              const BottomSheetTile(
                title: "Leave From",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    // homeController.getStudentRecord();
    // if(homeController.studentRecordList.isNotEmpty){
    //   getAllFeesList(studentId: GlobalVariable.studentId!, recordId: GlobalVariable.studentRecordId!);
    // }

    super.onInit();
  }
}
