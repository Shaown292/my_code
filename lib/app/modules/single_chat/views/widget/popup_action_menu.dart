import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class PopupActionMenu extends StatelessWidget {
  final Function()? onQuoteTap;
  final Function()? onForwardTap;
  final Function()? onDeleteTap;
  final double? positionRight;
  final double? positionLeft;
  final String? text;
  final Color? color;
  final TextStyle? textStyle;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final CrossAxisAlignment? crossAxisAlignment;

  const PopupActionMenu({
    super.key,
    this.onQuoteTap,
    this.onForwardTap,
    this.onDeleteTap,
    this.positionRight,
    this.positionLeft,
    this.text,
    this.color,
    this.textStyle,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            right: positionRight,
            left: positionLeft,
            top: Get.height * 0.5,
            child: Column(
              crossAxisAlignment: crossAxisAlignment!,
              children: [
                SizedBox(
                  width: 300,
                  child: ChatTextTile(
                    text: text,
                    color: color,
                    textStyle: textStyle,
                    radiusBottomLeft: radiusBottomLeft,
                    radiusBottomRight: radiusBottomRight,
                  ),
                ),
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: onQuoteTap,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.question_answer_outlined,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              10.horizontalSpacing,
                              const Text(
                                "Quote",
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(
                        width: Get.width,
                      ),
                      InkWell(
                        onTap: onForwardTap,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.forward_to_inbox,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              10.horizontalSpacing,
                              const Text(
                                "Forward",
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(
                        width: Get.width,
                      ),
                      InkWell(
                        onTap: onDeleteTap,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                              10.horizontalSpacing,
                              const Text(
                                "Delete",
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
