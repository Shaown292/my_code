import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class PopupActionMenu extends StatelessWidget {
  const PopupActionMenu({super.key});

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
            right: 20,
            top: Get.height * 0.5,
            child: Container(
              height: 160,
              width: 150,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child:  Column(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.question_answer_outlined, color: AppColors.primaryColor, size: 20,),
                          10.horizontalSpacing,
                          const Text("Quote", style: AppTextStyle.fontSize13BlackW400,),
                        ],
                      ),
                    ),
                  ),
                  CustomDivider(width: Get.width,),
                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.forward_to_inbox, color: AppColors.primaryColor, size: 20,),
                          10.horizontalSpacing,
                          const Text("Forward", style: AppTextStyle.fontSize13BlackW400,),
                        ],
                      ),
                    ),
                  ),

                  CustomDivider(width: Get.width,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
