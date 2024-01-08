import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class EventStatus extends StatelessWidget {

  final Color? color;
  final String? title;
  final int? numberOfDays;

  const EventStatus({
    super.key,
    this.color,
    this.title,
    this.numberOfDays,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 20,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(3), color: color),
          ),
          10.horizontalSpacing,
          Text(
            title ?? "",
            style: AppTextStyle.fontSize14GreyW400,
          ),
          const Spacer(),
          Text(
            "$numberOfDays ${"days".tr}",
            style: AppTextStyle.fontSize14GreyW400,
          ),

        ],
      ),
    );
  }
}
