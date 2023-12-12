import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/te_apply_leave_controller.dart';

class TeApplyLeaveView extends GetView<TeApplyLeaveController> {
  const TeApplyLeaveView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Apply Leave",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: SingleChildScrollView(
            child: Obx(() => Column(
              children: [
                controller.leaveLoader.value
                    ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
                    : DuplicateDropdown(
                  dropdownValue: controller.leaveTypeInitialValue.value,
                  dropdownList: controller.teacherLeaveTypeList,
                  changeDropdownValue: (v) {
                    controller.leaveTypeInitialValue.value = v!;
                    controller.leaveTypeId.value = v.id;

                  },
                ),
                10.verticalSpacing,

                /// Text Field
                CustomTextFormField(
                  iconOnTap: () {
                    controller.changeApplyDate();
                  },
                  readOnly: true,
                  controller: controller.applyDateTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Apply Date *",
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  iconOnTap: () {
                    controller.changeFromDate();
                  },
                  readOnly: true,
                  controller: controller.fromDateTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "From Date *",
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  iconOnTap: () {
                    controller.changeToDate();
                  },
                  readOnly: true,
                  controller: controller.toDateTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "To Date *",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText:
                  "${controller.file.value.path.isNotEmpty ? controller.file : 'Select File'}",
                  fillColor: Colors.white,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Browse",
                          style: AppTextStyle.fontSize12lightViolateW400,
                        ),
                        CustomDivider(
                          width: 42,
                          height: 1,
                          color: AppColors.profileValueColor,
                        ),
                      ],
                    ),
                  ),
                  iconOnTap: () {
                    controller.pickFile();
                    debugPrint("Browser ::: ${controller.file}");
                  },
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  controller: controller.reasonTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Reason",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                  maxLine: 3,
                  iconOnTap: () {
                    debugPrint("Browser");
                  },
                ),
                20.verticalSpacing,

                /// Button
                controller.loadingController.isLoading
                    ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
                    : PrimaryButton(
                  onTap: () {
                    if (controller.validation()) {

                    }
                  },
                  title: "Apply",
                  height: Get.height * 0.05,
                  radius: 30,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
