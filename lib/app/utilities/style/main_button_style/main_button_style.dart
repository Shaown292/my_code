import 'package:flutter/material.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';

ButtonStyle mainButtonStyle({
  required Color mainColor,
  double borderRadius = AppDimens.radius12,
}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      mainColor,
    ),
    overlayColor: MaterialStateColor.resolveWith(
      (states) => AppColors.primaryColor,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
    ),
  );
}
