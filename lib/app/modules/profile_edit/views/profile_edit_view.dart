import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'widget/edit_profile_text_field.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      title: "Edit Profile",
      actions: const [SizedBox()],
      bodyWidget: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              30.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfileFirstName,
                hintText: AppText.editProfileFirstName,
              ),
              15.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfileLastName,
                hintText: AppText.editProfileLastName,
              ),
              15.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfileEmail,
                hintText: AppText.editProfileEmail,
              ),
              15.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfilePhoneNumber,
                hintText: AppText.editProfilePhoneNumber,
              ),
              15.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfileDateOfBirth,
                hintText: AppText.editProfileDateOfBirth,
              ),
              15.verticalSpacing,
              const EditProfileTextField(
                labelText: AppText.editProfileCurrentAddress,
                hintText: AppText.editProfileCurrentAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
