import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../result/views/widget/flexible_text.dart';

class BookListTile extends StatelessWidget {
  final String? title;
  final String? subject;
  final int? quantity;
  final String? bookNumber;
  final double? price;
  final String? rackNo;
  final String? category;
  final Color? color;

  const BookListTile({
    super.key,
    this.title,
    this.subject,
    this.quantity,
    this.bookNumber,
    this.price,
    this.color,
    this.rackNo, this.category,
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
            style: AppTextStyle.homeworkView,
          ),
          10.verticalSpacing,
          Text(
            category ?? "",
            style: AppTextStyle.homeworkElements,
          ),
          10.verticalSpacing,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexibleText(
                text: "Subject",
              ),
              FlexibleText(
                text: "Book",
              ),
              FlexibleText(
                text: "Quantity",
              ),
              FlexibleText(
                text: "Price",
              ),
              FlexibleText(
                text: "Rack no",
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
                text: bookNumber ?? "",
              ),
              FlexibleText(
                text: '${quantity ?? ""}',
              ),
              FlexibleText(
                text: "${price ?? " "}",
              ),
              FlexibleText(
                text: rackNo ?? "",
              ),
            ],
          ),
        ],
      ),
    );


  }
}
