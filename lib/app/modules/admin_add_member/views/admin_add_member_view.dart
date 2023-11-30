import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_member_controller.dart';

class AdminAddMemberView extends GetView<AdminAddMemberController> {
  const AdminAddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Add Member",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller.idTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Enter ID",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
