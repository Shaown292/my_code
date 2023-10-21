import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class ScheduleDetailsTile extends StatelessWidget {

  final String? date;
  final String? subject;
  final String? time;
  final Color? color;

  const ScheduleDetailsTile({
    super.key,
    this.date,
    this.subject,
    this.time,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Date: ${date ?? ""}",
            style: AppTextStyle.fontSize14BlackW500,
          ),
          5.verticalSpacing,
           Text(
            "Subject: ${subject ?? ""}",
            style: AppTextStyle.fontSize14BlackW500,
          ),
          5.verticalSpacing,
           Text(
            "Time: ${time ?? ""}",
            style: AppTextStyle.fontSize14BlackW400,
          ),
          5.verticalSpacing,
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Room Number",
                    style: AppTextStyle.fontSize10GreyW300,
                  ),
                  5.verticalSpacing,
                  Text(
                    "07",
                    style: AppTextStyle.fontSize10GreyW300,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Class (Section)",
                    style: AppTextStyle.fontSize10GreyW300,
                  ),
                  5.verticalSpacing,
                  Text(
                    "21/22",
                    style: AppTextStyle.fontSize10GreyW300,
                  ),
                ],
              ),
              SizedBox(
                width: Get.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Teacher",
                      style: AppTextStyle.fontSize10GreyW300,
                    ),
                    5.verticalSpacing,
                    const Text(
                      "Noam Pash",
                      style: AppTextStyle.fontSize10GreyW300,

                    ),
                  ],
                ),
              ),
            ],
          ),
          5.verticalSpacing,



        ],
      ),
    );
  }
}
