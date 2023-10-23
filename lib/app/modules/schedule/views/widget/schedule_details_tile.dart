import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class ScheduleDetailsTile extends StatelessWidget {
  final String? date;
  final String? subject;
  final String? time;
  final String? roomNo;
  final String? section;
  final String? teacher;
  final Color? color;

  const ScheduleDetailsTile({
    super.key,
    this.date,
    this.subject,
    this.time,
    this.color,
    this.roomNo,
    this.section,
    this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color),
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
              ColumnTile(
                title: "Room Number",
                value: roomNo,
              ),
              ColumnTile(
                title: "Class (Section)",
                value: section,
              ),
              ColumnTile(
                title: "Teacher",
                value: teacher,
              ),



            ],
          ),
          5.verticalSpacing,
        ],
      ),
    );
  }
}
