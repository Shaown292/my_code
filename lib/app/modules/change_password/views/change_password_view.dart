import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Change Password",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpacing,
                const CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Current Password",
                  fillColor: Colors.white,
                ),
                10.verticalSpacing,
                const CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "New Password",
                  fillColor: Colors.white,
                ),
                10.verticalSpacing,
                const CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Confirm Password",
                  fillColor: Colors.white,
                ),
                10.verticalSpacing,
                 PrimaryButton(
                  title: "Save",
                  height: Get.height * 0.05,
                  radius: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
