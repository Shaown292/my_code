import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/result/views/widget/flexible_text.dart';
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

      padding: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title ?? "",

          ),
          10.verticalSpacing,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexibleText(
                text: "Subject",
              ),
              FlexibleText(
                text: "Marks",
              ),
              FlexibleText(
                text: "Obtain",
              ),
              FlexibleText(
                text: "Grade",
              ),
            ],
          ),
            10.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexibleText(
                text: subject ?? "",
              ),
              FlexibleText(
                text: marks ?? "",
              ),
              FlexibleText(
                text: obtain ?? "",
              ),
              FlexibleText(
                text: grade ?? "",
              ),



            ],
          ),
        ],
      ),
    );
  }
}

