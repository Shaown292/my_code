import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_nav_button/bottom_nav_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/apply_leave_controller.dart';

class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Apply Leave".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller.dropdownValue.value,
                          dropdownList: controller.applyLeaveTypeList,
                          changeDropdownValue: (v) {
                            controller.dropdownValue.value = v!;
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
                    hintText: "${"Apply Date".tr} *".tr,
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
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
                    hintText: "${"From Date".tr} *".tr,
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
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
                    hintText: "${"To Date".tr} *".tr,
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
                        "${controller.file.value.path.isNotEmpty ? controller.file : 'Select File'.tr}",
                    fillColor: Colors.white,
                    suffixIcon:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Browse".tr,
                            style: AppTextStyle.fontSize12lightViolateW400,
                          ),
                          const CustomDivider(
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
                  ),
                  10.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.reasonTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Reason".tr,
                    fillColor: Colors.white,
                    maxLine: 3,

                  ),
                  20.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavBar:   /// Button
      controller.loadingController.isLoading
          ? const SecondaryLoadingWidget(
        isBottomNav: true,
      )
          : BottomNavButton(
        onTap: () {
          if (controller.validation()) {
            controller.applyLeave();
          }
        },
        text: 'Apply'.tr,
      ),
    );
  }
}
