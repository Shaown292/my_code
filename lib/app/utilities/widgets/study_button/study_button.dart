import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class StudyButton extends StatelessWidget {

  final Color? color;
  final double? height;
  final double? weight;
  final String? title;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Function()? onItemTap;
  final bool isSelected;

  const StudyButton({
    super.key,
    this.color,
    this.height,
    this.weight,
    this.title,
    this.borderColor,
    this.textStyle,
    this.onItemTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(width: 1, color: isSelected ? Colors.transparent : AppColors.primaryColor),
          color: isSelected ?   AppColors.appButtonColor :  Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title ?? "Button",
              style:  isSelected ? AppTextStyle.textStyle12WhiteW500 : AppTextStyle.cardTextStyle12PurpleW400,
            ),
          ),
        ),
      ),
    );
  }
}
