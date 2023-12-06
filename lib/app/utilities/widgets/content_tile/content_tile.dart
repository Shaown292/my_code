import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../data/constants/app_colors.dart';
import '../button/primary_button.dart';

class ContentTile extends StatelessWidget {
  final String? dueDate;
  final String? title;
  final String? details;
  final Function()? onTap;
  final Color? cardBackgroundColor;

  const ContentTile({
    super.key,
    this.dueDate,
    this.title,
    this.details,
    this.onTap,
    this.cardBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: cardBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
              5.verticalSpacing,
              Text(
                details ?? "",
                style: const TextStyle(
                  color: AppColors.syllabusTextColor635976,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              10.verticalSpacing,
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xFFFE3E3E)),
                    child: Center(
                      child: Text(
                        "Due - $dueDate",
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                    ),
                  ),
                  5.horizontalSpacing,
                  Expanded(
                    child: PrimaryButton(
                      title: "DOWNLOAD",
                      onTap: onTap,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
