import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/apply_leave_controller.dart';

class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Apply Leave",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// Text Field
                CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Apply Date",
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
                  hintText: "From Date",
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                  iconOnTap: () {
                    debugPrint("tapped on from date");
                  },
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "To Date",
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
                  hintText: "Select File",
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
                    debugPrint("Browser");
                  },
                ),
                10.verticalSpacing,
                CustomTextFormField(
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
                PrimaryButton(
                  title: "Apply",
                  height: Get.height * 0.05,
                  radius: 30,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
