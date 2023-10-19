import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const textStyle12WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static const textStyle11WhiteW300 = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
  );

  static const textStyle10WhiteW400 = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const textStyle16WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static const textStyle7WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: 7,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
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

  static const fontSize18WhiteW500 = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500);

  /// Syllabus
  static const fontSize14BlackW500 = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static const blackFontSize14W400 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const syllabusFontSize16W500 = TextStyle(
      color: AppColors.syllabusTextColor412C56,
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static const notificationText = TextStyle(
      color: AppColors.syllabusTextColor412C56,
      fontSize: 10,
      fontWeight: FontWeight.w400);

  static const labelText = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize: 8,
      fontWeight: FontWeight.w400);

  ///Homework
  static const homeworkSubject = TextStyle(
      color: AppColors.homeworkSubjectColor,
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static const homeworkElements = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize: 10,
      fontWeight: FontWeight.w400);

  static const homeworkView = TextStyle(
      color: AppColors.homeworkViewColor,
      fontSize: 14,
      // decoration: TextDecoration.underline,
      fontWeight: FontWeight.w500);
}
