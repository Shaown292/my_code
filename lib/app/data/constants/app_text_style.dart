import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const textStyle12WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static const textStyle10WhiteW400 = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const cardTextStyle14PurpleW500 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static const cardTextStyle14WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  /// Profile
  static const fontSize14LightPinkW400 = TextStyle(
      color: AppColors.profileCardTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  /// Syllabus
  static const fontSize14BlackW500 = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static const syllabusFontSize14W400 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const syllabusFontSize16W500 = TextStyle(
      color: AppColors.syllabusTextColor412C56,
      fontSize: 16,
      fontWeight: FontWeight.w500);
}
