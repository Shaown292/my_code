import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
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

    controller.fetchProfileData();
    return CustomScaffoldWidget(
      title: "Edit Profile",
      actions: const [SizedBox()],
      bodyWidget: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Container(
                   height: Get.height * 0.3,
                   width: Get.width * 0.3,
                   decoration:  BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(
                         image: AssetImage(ImagePath.parentsProfile),
                       fit: BoxFit.fill
                     )
                   ),
                 ),
                 EditProfileTextField(
                  labelText: AppText.editProfileFirstName,
                  hintText: AppText.editProfileFirstName,
                  controller: controller.firstNameController,

                ),
                15.verticalSpacing,
                 EditProfileTextField(
                  labelText: AppText.editProfileLastName,
                  hintText: AppText.editProfileLastName,
                  controller: controller.lastNameController,
                ),
                15.verticalSpacing,
                 EditProfileTextField(
                  labelText: AppText.editProfileEmail,
                  hintText: AppText.editProfileEmail,
                  controller: controller.email,
                ),
                15.verticalSpacing,
                 EditProfileTextField(
                  labelText: AppText.editProfilePhoneNumber,
                  hintText: AppText.editProfilePhoneNumber,
                  controller: controller.phoneNumber,
                ),
                15.verticalSpacing,
                 EditProfileTextField(
                  labelText: AppText.editProfileDateOfBirth,
                  hintText: AppText.editProfileDateOfBirth,
                  controller: controller.dateOfBirth,
                ),
                15.verticalSpacing,
                 EditProfileTextField(
                  labelText: AppText.editProfileCurrentAddress,
                  hintText: AppText.editProfileCurrentAddress,
                   controller: controller.currentAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
