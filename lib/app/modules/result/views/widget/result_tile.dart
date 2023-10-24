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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title ?? "Pair Match Test",

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


           // Column(
           //      crossAxisAlignment: CrossAxisAlignment.start,
           //      mainAxisAlignment: MainAxisAlignment.start,
           //      children: [
           //        const Text(
           //         "Subject",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        const Text(
           //          "Marks",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        const Text(
           //          "Obtain",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        const Text(
           //          "Grade",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        8.verticalSpacing,
           //
           //      ],
           //    ),
           // Column(
           //      crossAxisAlignment: CrossAxisAlignment.start,
           //      mainAxisAlignment: MainAxisAlignment.start,
           //      children: [
           //        const Text(
           //         "Marks",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        8.verticalSpacing,
           //        Flexible(
           //          child: Text(
           //            marks ?? "",
           //            style: AppTextStyle.homeworkElements,
           //            overflow: TextOverflow.ellipsis,
           //          ),
           //        ),
           //      ],
           //    ),
           // Column(
           //      crossAxisAlignment: CrossAxisAlignment.start,
           //      mainAxisAlignment: MainAxisAlignment.start,
           //      children: [
           //        const Text(
           //         "Obtain",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        8.verticalSpacing,
           //        Text(
           //          obtain ?? "",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //      ],
           //    ),  // ColumnTile(
           // Column(
           //      crossAxisAlignment: CrossAxisAlignment.start,
           //      mainAxisAlignment: MainAxisAlignment.start,
           //      children: [
           //        const Text(
           //         "Grade",
           //          style: AppTextStyle.homeworkElements,
           //        ),
           //        8.verticalSpacing,
           //        Text(
           //          grade ?? "",
           //          style: AppTextStyle.homeworkElements,
           //          overflow: TextOverflow.ellipsis,
           //        ),
           //      ],
           //    ),

            
            ],
          ),
            10.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

