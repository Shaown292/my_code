import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Change Passowrd",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              20.verticalSpacing,
              const CustomTextFormField(
                enableBorderActive: true,
                focusBorderActive: true,
                hintText: "Current Password",
              ),
              10.verticalSpacing,
              const CustomTextFormField(
                enableBorderActive: true,
                focusBorderActive: true,
                hintText: "New Password",
              ),
              10.verticalSpacing,
              const CustomTextFormField(
                enableBorderActive: true,
                focusBorderActive: true,
                hintText: "Confirm Password",
              ),
              10.verticalSpacing,
              const PrimaryButton(
                title: "Save",
                height: 40,
                radius: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
