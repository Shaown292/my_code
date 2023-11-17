import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class SettingsTile extends StatelessWidget {
  final String? icon;
  final Color? iconColor;
  final String? title;
  final double? iconHeight;
  final double? iconWidth;
  final bool isLanguage;
  final Color? backgroundColor;
  final Function()? onTileTap;

  const SettingsTile({
    super.key,
    this.icon,
    this.title,
    this.isLanguage = true,
    this.onTileTap,
    this.iconColor,
    this.iconHeight,
    this.iconWidth,
    this.backgroundColor,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor ?? AppColors.homeTextColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        icon ?? "",
                        color: iconColor ?? Colors.white,
                        height: iconHeight ?? 20,
                        width: iconWidth ?? 20,
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
