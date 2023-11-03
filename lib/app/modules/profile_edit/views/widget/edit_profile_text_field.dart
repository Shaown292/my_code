import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';

import '../../../../data/constants/image_path.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final bool focusBorderActive;
  final bool enableBorderActive;
  final bool obsCureText;
  final Widget? suffixIcon;
  final Function()? iconOnTap;
  final TextInputType? textInputType;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final Color? enableBorderActiveColor;
  final int? maxLine;


  const EditProfileTextField ({
    this.controller,
    this.fillColor,
    this.hintText,
    this.focusBorderActive = true,
    this.enableBorderActive = true,
    this.suffixIcon,
    this.iconOnTap,
    this.obsCureText = false,
    this.textInputType,
    this.labelText,
    this.labelTextStyle,
    this.enableBorderActiveColor,
    super.key, this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsCureText,
      keyboardType: textInputType,
      minLines: 1,
      maxLines: maxLine ?? 1,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText ?? "label",
        labelStyle: labelTextStyle ?? AppTextStyle.labelText,
        fillColor: fillColor ?? const Color(0xFFFDFBFF),
        hintText: hintText ?? 'Enter text',
        suffixIcon: InkWell(
          onTap: iconOnTap,
          child: Image.asset(
            ImagePath.editBlack,
            height: 10,
            width: 10,
            scale: 3,
          ),
        ),
        focusedBorder: focusBorderActive
            ? OutlineInputBorder(
          borderSide:  BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8.0),
        )
            : null,
        enabledBorder: enableBorderActive
            ? OutlineInputBorder(
          borderSide:  BorderSide(color: enableBorderActiveColor ?? const Color(0xFF635976).withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8.0),
        )
            : null,
      ),
    );
  }
}
