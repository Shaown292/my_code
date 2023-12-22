import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class FeesTile extends StatelessWidget {
  final String? duration;
  final String? dueDate;
  final String? amount;
  final String? paid;
  final String? balance;

  final String? statusText;
  final Color? statusColor;
  final Function()? onTap;

  const FeesTile({
    super.key,
    this.duration,
    this.dueDate,
    this.amount,
    this.paid,
    this.balance,
    this.onTap,
    this.statusColor,
    this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duration ?? "",
                style: AppTextStyle.homeworkSubject,
              ),
              InkWell(
                onTap: onTap,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "View",
                        style: AppTextStyle.homeworkView,
                      ),
                    ),
                    CustomDivider(
                      width: 35,
                      height: 1,
                      color: AppColors.homeworkViewColor,
                    ),
                  ],
                ),
              )
            ],
          ),
          20.verticalSpacing,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ColumnTile(
                    title: "Amount",
                    value: amount,
                  ),
                  ColumnTile(
                    title: "Paid",
                    value: paid,
                  ),
                  ColumnTile(
                    title: "Balance",
                    value: balance,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Status",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        5.verticalSpacing,
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: statusColor ??
                                  AppColors.homeworkStatusRedColor),
                          child: Center(
                            child: Text(
                              statusText ?? "",
                              style: AppTextStyle.textStyle10WhiteW400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              20.verticalSpacing,
              ColumnTile(
                title: "Due Date",
                value: dueDate,
              ),
              10.verticalSpacing,
              const CustomDivider(color: AppColors.customDividerColor,)
            ],
          ),
        ],
      ),
    );
  }
}
