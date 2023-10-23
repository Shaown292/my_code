import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class SettingsTile extends StatelessWidget {
  final String? icon;
  final String? title;
  final bool isLanguage;
  final Function()? onTileTap;
  final Color? color;
  const SettingsTile({
    super.key,
    this.icon,
    this.title,
    this.isLanguage = true,
    this.onTileTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTileTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.homeTextColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        icon ?? "",
                        height: 24,
                        width: 24,
                        color: color ?? Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpacing,
                  Text(
                    title ?? "",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                ],
              ),
              isLanguage
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.homeTextColor,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: Center(
                          child: Text(
                            "English",
                            style: AppTextStyle.textStyle12WhiteW500,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        8.verticalSpacing,
        CustomDivider(
          width: Get.width,
        )
      ],
    );
  }
}
