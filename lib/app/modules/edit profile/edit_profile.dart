import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/edit%20profile/widget/edit_profile_text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import '../../data/constants/app_text.dart';
import '../../data/constants/image_path.dart';
import '../../utilities/widgets/common_widgets/text_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScaffoldWidget(
      title: "Edit Profile",
      actions: [
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 17,
            width: 17,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.edit),
                  filterQuality: FilterQuality.high
              ),
            ),
          ),
        ),
      ],
      bodyWidget:   CustomBackground(customWidget: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
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
      )),
    );
  }
}
