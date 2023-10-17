import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:get/get.dart';

class EditProfileTextField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  const EditProfileTextField({super.key, this.hintText, this.labelText, this.controller});

  @override
  Widget build(BuildContext context) {
    return  CustomTextFormField(
      enableBorderActive: true,
      focusBorderActive: true,
     hintText: hintText,
      label: labelText,
      maxLine: 2,
      controller: controller,

      suffixIcon: Container(
        width: Get.width * 0.02,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.editBlack)
          )
        ),
      )
    );
  }
}
