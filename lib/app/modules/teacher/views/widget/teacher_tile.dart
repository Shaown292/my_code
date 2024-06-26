import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

class TeacherTile extends StatelessWidget {

  final String? teachersName;
  final String? teachersEmail;
  final String? teachersPhoneNo;
  final Color? tileBackgroundColor;

  const TeacherTile({
    super.key,
    this.teachersName,
    this.teachersEmail,
    this.teachersPhoneNo,
    this.tileBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: tileBackgroundColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImagePath.teacher,
                  height: 13,
                  width: 13,
                ),
                10.horizontalSpacing,
                Text(
                  teachersName ?? AppText.noDataAvailable,
                  style: AppTextStyle.teacherColor,
                )
              ],
            ),
            15.verticalSpacing,
            Row(
              children: [
                Image.asset(
                  ImagePath.mail,
                  height: 13,
                  width: 13,
                  color: AppColors.profileValueColor,
                ),
                10.horizontalSpacing,
                Text(
                  teachersEmail ?? AppText.noDataAvailable,
                  style: AppTextStyle.fontSize13GreyW300,
                )
              ],
            ),
            15.verticalSpacing,
            Row(
              children: [
                Image.asset(
                  ImagePath.phone,
                  height: 13,
                  width: 13,
                  color: AppColors.profileValueColor,
                ),
                10.horizontalSpacing,
                Text(
                  teachersPhoneNo ?? AppText.noDataAvailable,
                  style: AppTextStyle.fontSize13GreyW300,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
