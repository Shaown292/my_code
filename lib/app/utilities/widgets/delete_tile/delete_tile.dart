import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DeleteTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function()? tapLeftButton;
  final Function()? tapRightButton;
  final Color? color;
  final String? leftIcon;
  final Color? leftIconBackgroundColor;
  final String? rightIcon;
  final Color? rightIconBackgroundColor;

  const DeleteTile({
    super.key,
    this.title,
    this.subTitle,
    this.tapLeftButton,
    this.tapRightButton,
    this.color,
    this.leftIcon,
    this.rightIcon,
    this.leftIconBackgroundColor,
    this.rightIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.parentsCardBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width*0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: AppTextStyle.syllabusFontSize16W500,
                      ),
                      5.verticalSpacing,
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          subTitle ?? "",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    leftIcon == null
                        ? const SizedBox()
                        : InkWell(
                            onTap: tapLeftButton,
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: leftIconBackgroundColor),
                              child: Center(
                                child: Image.asset(
                                  leftIcon ?? "",
                                ),
                              ),
                            ),
                          ),
                    7.horizontalSpacing,
                    rightIcon == null
                        ? const SizedBox()
                        : InkWell(
                            onTap: tapRightButton,
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: rightIconBackgroundColor,
                              ),
                              child: Center(
                                child: Image.asset(
                                  rightIcon ?? "",
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
