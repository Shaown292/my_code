

import 'package:flutter/material.dart';
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
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(icon ?? ""))),
                ),
                10.horizontalSpacing,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style:  const TextStyle(
                          color: AppColors.profileTitleColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    5.verticalSpacing,
                    Text(
                      value ?? "",
                      style:  const TextStyle(
                          color: AppColors.profileValueColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
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
