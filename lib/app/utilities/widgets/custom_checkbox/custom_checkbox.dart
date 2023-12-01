import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

class CustomCheckbox extends StatelessWidget {
  final bool checkboxValue;
  final Function(bool?)? onChange;
  final String? checkboxTitle;
  final OutlinedBorder? shape;
  const CustomCheckbox({super.key,  this.checkboxValue = false, this.onChange, this.checkboxTitle, this.shape});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        16.horizontalSpacing,
        Checkbox(
          value: checkboxValue,
          onChanged: onChange,
          shape: shape,
        ),
        15.horizontalSpacing,
         Text(
          checkboxTitle ?? "",
          style: AppTextStyle.fontSize13BlackW400,
        ),
      ],
    );
  }
}
