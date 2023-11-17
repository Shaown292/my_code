import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class IssuedBookTile extends StatelessWidget {
  final String? issuedDate;
  final String? returnDate;
  final String? bookNo;
  final String? bookName;
  final String? status;
  final String? activeStatus;
  final Color? activeStatusColor;

  const IssuedBookTile({
    super.key,
    this.issuedDate,
    this.returnDate,
    this.bookNo,
    this.status,
    this.bookName, this.activeStatus, this.activeStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookName ?? "",
            style: AppTextStyle.fontSize14lightViolateW400,
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: "Issued Date",
                value: issuedDate,
              ),
              ColumnTile(
                title: "Return Date",
                value: returnDate,
              ),
              ColumnTile(
                title: "Book No",
                value: bookNo,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status",
                    style: AppTextStyle.homeworkElements,
                  ),
                  5.verticalSpacing,
                  activeStatus != null
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: activeStatusColor),
                          child: Center(
                            child: Text(
                              activeStatus ?? "",
                              style: AppTextStyle.textStyle10WhiteW400,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
           10.verticalSpacing,
           CustomDivider(
            width: Get.width,
             color: AppColors.dormitoryDividerColor,
          ),
        ],
      ),
    );
  }
}
