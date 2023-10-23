import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';

class ResultTile extends StatelessWidget {
  final String? title;
  final String? subject;
  final String? obtain;
  final String? marks;
  final String? grade;
  final Color? color;

  const ResultTile({
    super.key,
    this.title,
    this.subject,
    this.obtain,
    this.marks,
    this.grade,
    this.color,
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
            title ?? "Pair Match Test",
            style: AppTextStyle.fontSize14lightViolateW400,
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Subject",
                value: subject ?? "",
              ),
              5.horizontalSpacing,
              ColumnTile(
                title: "Marks",
                value: marks ?? "",
              ),
              5.horizontalSpacing,
              ColumnTile(
                title: "Obtain",
                value: obtain ?? "",
              ),
              5.horizontalSpacing,
              ColumnTile(
                title: "Grade",
                value: grade ?? "",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
