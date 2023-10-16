import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/edit%20profile/edit_profile.dart';
import 'package:get/get.dart';

class EditProfileRoute extends StatelessWidget {
  const EditProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
      Get.to(const EditProfile());
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
