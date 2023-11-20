import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';

class NoticeCard extends StatelessWidget {
  final String? noticeTitle;
  final String? noticeDetails;
  final String? noticeDate;
  final Function()? onTap;
  final Color? cardBackgroundColor;

  const NoticeCard({
    super.key,
    this.noticeTitle,
    this.noticeDetails,
    this.noticeDate,
    this.onTap,
    this.cardBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cardBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticeTitle ?? "",
                  style: AppTextStyle.fontSize16lightViolateW500,
                ),
                5.verticalSpacing,
                Text(
                  noticeDetails ?? "",
                  style: AppTextStyle.blackFontSize12W400,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                10.verticalSpacing,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFFE3E3E)),
                      child: Center(
                        child: Text(
                          "Published: ${noticeDate ?? AppText.noDataAvailable}",
                          style: AppTextStyle.cardTextStyle14WhiteW500,
                        ),
                      ),
                    ),
                    10.horizontalSpacing,
                    Expanded(
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.appButtonColor),
                          child: const Center(
                            child: Text(
                              "View",
                              style: AppTextStyle.cardTextStyle14WhiteW500,
                            ),
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
