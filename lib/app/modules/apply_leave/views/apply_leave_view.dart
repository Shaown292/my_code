import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../../../utilities/widgets/custom_dropdown.dart';
import '../controllers/apply_leave_controller.dart';

class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({super.key});

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
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0),
                            child: CustomDropdown(
                              dropdownValue: controller.dropdownValue.value,
                              scheduleList: controller.leaveTypeDropdownList
                                  .map((item) => item.toString())
                                  .toList(),
                              changeDropdownValue: (v) {
                                controller.dropdownValue.value = v!;
                                controller.leaveTypeId.value = controller
                                    .applyLeaveTypeList[controller
                                        .leaveTypeDropdownList
                                        .indexOf(v)]
                                    .id!;
                              },
                            ),
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
                    ),
                    10.verticalSpacing,
                    CustomTextFormField(
                      controller: controller.reasonTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "Reason",
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
                                controller.applyLeave();
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
