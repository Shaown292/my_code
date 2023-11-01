import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class OthersTile extends StatelessWidget {
  final String title;
  final String value;

  const OthersTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width / 2,
              child: Text(
                title,
                style: AppTextStyle.fontSize10GreyW500
              ),
            ),
            Text(
              value,
              style: AppTextStyle.fontSize10GreyW500
            ),
          ],
        ),
        10.verticalSpacing,
        CustomDivider(
          width: Get.width,
          color: AppColors.profileDividerColor,
        ),
        30.verticalSpacing,
      ],
    );
  }
}