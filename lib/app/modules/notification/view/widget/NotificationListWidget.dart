

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.parentsProfile),
                          ),

                        ),
                      ),
                      20.horizontalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Patrik Nelson",
                            style: AppTextStyle.blackFontSize14W400,
                          ),
                          7.verticalSpacing,
                          const Text(
                            "9 minutes ago.",
                            style: AppTextStyle.notificationText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpacing,
                  CustomDivider(
                    width: Get.width,
                    color: AppColors.profileDividerColor,
                  )
                ],
              ),
            );
          }
      ),
    );
      
      
  }
}
