import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class LanguageBottomSheet extends StatelessWidget {
  final int? index;
  final String? title;
  final Color? color;
  const LanguageBottomSheet({
    super.key,
    this.index,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.verticalSpacing,
          const CustomDivider(
            height: 3,
            width: 30,
          ),
          30.verticalSpacing,
          Container(
            height: 50,
            width: Get.width,
            color: color,
            child: Center(
              child: Text(
                title ?? "",
                style: AppTextStyle.blackFontSize14W400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
