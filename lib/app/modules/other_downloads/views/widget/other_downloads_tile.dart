import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/button/primary_button.dart';
import '../../../../utilities/widgets/common_widgets/custom_container_widget.dart';

class OtherDownloadsTile extends StatelessWidget {
  final String? contentTitle;
  final String? topic;
  final String? date;
  final Function()? onTap;

  const OtherDownloadsTile({
    super.key,
     this.contentTitle,
     this.topic,
    this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWidget(
          borderColor: const Color(0xFFEAE7F0),
          color: Colors.white,
          borderWidth: 1,
          requiredWidget: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFF2F0F6),
                      ),
                      child: Center(
                        child: Text(
                          contentTitle ?? "",
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.3,
                      child: Text(
                        "Date: $date",
                        style: AppTextStyle.blackFontSize14W400,
                      ),
                    ),
                  ],
                ),
                10.verticalSpacing,
                Text(
                  topic ?? "",
                  style: AppTextStyle.blackFontSize14W400,
                ),
                20.verticalSpacing,
                PrimaryButton(
                  onTap: onTap,
                  title: "Download",
                ),
              ],
            ),
          )),
    );
  }
}
