import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class TransportWidget extends StatelessWidget {
  const TransportWidget({super.key, this.title, this.value});

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.35,
              child: Text(
                title ?? AppText.noDataAvailable.tr,
                style:const TextStyle(
                    color: AppColors.profileValueColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              value ?? AppText.noDataAvailable.tr,
              style: AppTextStyle.fontSize10GreyW500,
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
