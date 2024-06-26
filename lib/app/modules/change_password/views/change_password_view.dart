import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Change Password".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpacing,
                 CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Current Password".tr,
                  fillColor: Colors.white,
                  controller: controller.currentPasswordController,
                ),
                10.verticalSpacing,
                 CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "New Password".tr,
                  fillColor: Colors.white,
                   controller: controller.newPasswordController,
                ),
                10.verticalSpacing,
                 CustomTextFormField(
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Confirm Password".tr,
                  fillColor: Colors.white,
                   controller: controller.confirmPasswordController,
                ),
                30.verticalSpacing,
                 Obx(() => controller.passLoader.value ? const SecondaryLoadingWidget() : PrimaryButton(
                   onTap: (){
                     if(controller.validation()){
                       controller.changePassword();
                     }
                   },
                   title: "Save".tr,
                   height: Get.height * 0.05,
                   radius: 30,
                 ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
