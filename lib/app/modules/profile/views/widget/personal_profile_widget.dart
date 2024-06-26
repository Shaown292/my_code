

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';


class ProfilePersonalWidget extends StatelessWidget {

   const ProfilePersonalWidget({super.key, this.value, this.icon, this.title});
   final String? value;
   final String? icon;
   final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            7.verticalSpacing,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                  width: 15,
                  child: Image.asset(icon ?? "", height: 15, width: 15, color: AppColors.syllabusTextColorBlack,),
                ),
                10.horizontalSpacing,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style:  AppTextStyle.fontSize10GreyW400,
                    ),
                    5.verticalSpacing,
                    Text(
                      value ?? "",
                      style:  AppTextStyle.fontSize10GreyW500,
                    ),
                  ],
                ),
              ],
            ),
            20.verticalSpacing,
            CustomDivider(
              width: Get.width,
              color: AppColors.profileDividerColor,
            )
          ],
        ),

      ],
    );
  }
}
