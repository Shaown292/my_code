import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceTile extends StatelessWidget {
  final String? studentName;
  final String? studentClass;
  final String? studentSection;
  final String? date;
  final String? amount;
  final String? paid;
  final String? balance;
  final String? status;
  final Color? statusColor;
  final Function()? onTapView;
  final Function()? onTapViewTransaction;
  final Function()? onTapDelete;

  const AdminFeesInvoiceTile({
    super.key,
    this.studentName,
    this.studentClass,
    this.studentSection,
    this.date,
    this.amount,
    this.paid,
    this.balance,
    this.status,
    this.statusColor,
    this.onTapView,
    this.onTapViewTransaction,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${studentName ?? ""} (${studentClass ?? ""} - ${studentSection ?? ""})",
                style: AppTextStyle.homeworkSubject,
              ),
              Row(
                children: [
                  Text(
                    date ?? "",
                    style: AppTextStyle.homeworkSubject,
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    iconColor: AppColors.homeworkSubjectColor,
                    iconSize: 20,
                    color: Colors.white,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("View"),
                        onTap: onTapView,
                      ),
                      PopupMenuItem(
                        child: const Text("View Transaction"),
                        onTap: onTapViewTransaction,
                      ),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: onTapDelete,
                      ),
                    ],
                  ),
                ],
              ),
              5.verticalSpacing,
              Row(
                children: [
                  ColumnTile(
                    title: "Amount",
                    value: amount ?? "",
                  ),
                  ColumnTile(
                    title: "Paid",
                    value: paid ?? "",
                  ),
                  ColumnTile(
                    title: "Balance",
                    value: balance ?? "",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      Container(
                        width: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: statusColor),
                        child: Center(
                          child: Text(
                            status ?? "",
                            style: AppTextStyle.textStyle12WhiteW400,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        ),
      ],
    );
  }
}
