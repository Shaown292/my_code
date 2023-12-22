import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_dimens.dart';
import '../../../data/constants/app_text.dart';
import '../../../service/image/image_picker_utils.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/image_view/cache_image_view.dart';
import 'widget/edit_profile_text_field.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Edit Profile",
      actions: const [SizedBox()],
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                50.verticalSpacing,

                Obx(
                  () => Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      controller.profileDataController.profilePickedImage.value
                              .path.isEmpty
                          ? controller.profileDataController.profilePhoto
                                      .isEmpty ||
                                  controller.profileDataController.profilePhoto
                                          .value ==
                                      ''
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImagePath.editProfileImage),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: 100.circularRadius,
                                    child: CacheImageView(
                                      url:
                                          controller.profileDataController.profilePhoto.toString(),
                                      errorImageLocal:
                                          'assets/image/production/avatar.png',
                                    ),
                                  ),
                                )
                          : ClipRRect(
                              borderRadius: AppDimens.radius100.circularRadius,
                              child: Image.file(
                                height: 100,
                                width: 100,
                                File(controller.profileDataController
                                    .profilePickedImage.value.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          bottom: 10,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              FlutterImagePickerUtils.imagePickerModalSheet(
                                context: context,
                                fromGallery: () async {
                                  controller.profileDataController
                                          .profilePickedImage.value =
                                      await FlutterImagePickerUtils
                                          .getImageGallery(
                                    context,
                                  );
                                  if (controller
                                      .profileDataController
                                      .profilePickedImage
                                      .value
                                      .path
                                      .isNotEmpty) {
                                    controller.profilePhotoUpdate(
                                        file: controller.profileDataController
                                            .profilePickedImage.value.path);
                                  }
                                },
                                fromCamera: () async {
                                  controller.profileDataController
                                          .profilePickedImage.value =
                                      await FlutterImagePickerUtils
                                          .getImageCamera(
                                    context,
                                  );
                                  if (controller
                                      .profileDataController
                                      .profilePickedImage
                                      .value
                                      .path
                                      .isNotEmpty) {
                                    controller.profilePhotoUpdate(
                                        file: controller.profileDataController
                                            .profilePickedImage.value.path);
                                  }
                                },
                              );
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor),
                              child: Center(
                                child: Image.asset(
                                  ImagePath.edit,
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                            ),
                          ) //Icon
                          ),
                    ], //<Widget>[]
                  ),
                ),
                //
                30.verticalSpacing,

                EditProfileTextField(
                  labelText: AppText.editProfileFirstName,
                  controller: controller.firstNameTextController,
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                ),
                15.verticalSpacing,
                EditProfileTextField(
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                  labelText: AppText.editProfileLastName,
                  hintText: AppText.editProfileLastName,
                  controller: controller.lastNameTextController,
                ),
                15.verticalSpacing,
                EditProfileTextField(
                  labelText: AppText.editProfileEmail,
                  readOnly:
                      controller.globalRxVariableController.roleId.value == 1
                          ? false
                          : true,
                  suffixIcon:
                      controller.globalRxVariableController.roleId.value == 1
                          ? InkWell(
                        onTap: () => controller.userProfileInfoUpdate(),
                            child: Image.asset(
                                ImagePath.editBlack,
                                height: 10,
                                width: 10,
                                scale: 3,
                              ),
                          )
                          : const SizedBox(),
                  hintText: AppText.editProfileEmail,
                  controller: controller.emailTextController,
                ),
                15.verticalSpacing,
                EditProfileTextField(
                  labelText: AppText.editProfilePhoneNumber,
                  suffixIcon:
                      controller.globalRxVariableController.roleId.value == 1
                          ? InkWell(
                        onTap: () => controller.userProfileInfoUpdate(),
                            child: Image.asset(
                                ImagePath.editBlack,
                                height: 10,
                                width: 10,
                                scale: 3,
                              ),
                          )
                          : const SizedBox(),
                  readOnly:
                      controller.globalRxVariableController.roleId.value == 1
                          ? false
                          : true,
                  hintText: AppText.editProfilePhoneNumber,
                  controller: controller.phoneNumberTextController,
                ),
                15.verticalSpacing,
                EditProfileTextField(
                  readOnly: true,
                  labelText: AppText.editProfileDateOfBirth,
                  suffixIcon: InkWell(
                    onTap: (){
                      controller.dateOfBirth();
                    },
                    child: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                  ),
                  hintText: AppText.editProfileDateOfBirth,
                  controller: controller.dateOfBirthTextController,
                ),
                15.verticalSpacing,
                EditProfileTextField(
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                  labelText: AppText.editProfileCurrentAddress,
                  hintText: AppText.editProfileCurrentAddress,
                  controller: controller.currentAddressTextController,
                ),
                50.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
