import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../../domain/core/model/profile/profile_personal_model.dart';

class EditProfileRoute extends StatelessWidget {
  const EditProfileRoute({super.key, this.profilePersonal});

  final ProfilePersonal? profilePersonal;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
      Get.toNamed(Routes.PROFILE_EDIT, arguments: {"profile_personal": profilePersonal});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
    );
  }
}
