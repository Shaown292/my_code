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
  final String? fine;
  final String? waiver;
  final String? subTotal;

  final String? statusText;
  final Color? statusColor;
  final Function()? onTap;
  final Function()? onViewInvoiceTap;
  final Function()? onAddPaymentTap;
  final bool isInvoice;

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
    this.onViewInvoiceTap,
    this.onAddPaymentTap,
    this.isInvoice = false, this.fine, this.waiver, this.subTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isInvoice
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      duration ?? "",
                      style: AppTextStyle.homeworkSubject,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        iconColor: Colors.white,
                        child: const Text(
                          "View",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            onTap: onViewInvoiceTap,
                            child: const Text("View Invoice"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            onTap: onAddPaymentTap,
                            child: const Text("Add Payment"),
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
                    title: isInvoice ? "Fine" : "Balance",
                    value: isInvoice ? fine : balance,
                  ),
                  isInvoice
                      ? Flexible(
                        child: ColumnTile(
                            title: "Waiver" ,
                            value: waiver,
                          ),
                      )
                      : Flexible(
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
                title: isInvoice ? "Sub Total" : "Due Date",
                value: isInvoice ? subTotal :dueDate,
              ),
              10.verticalSpacing,
              const CustomDivider(
                color: AppColors.customDividerColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
