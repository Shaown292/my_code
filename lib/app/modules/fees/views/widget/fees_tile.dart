import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';
import 'two_value_tile.dart';

class FeesTile extends StatelessWidget {
  final String? duration;
  final String? dueDate;
  final String? amount;
  final String? paid;
  final String? balance;
  final String? fine;
  final String? status;
  final String? waiver;
  final String? subTotal;
  final String? statusText;
  final String? totalAmount;
  final String? totalFine;
  final String? totalPaid;
  final String? grandTotal;
  final String? dueBalance;
  final String? totalWaiver;
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
    this.isInvoice = false,
    this.fine,
    this.waiver,
    this.subTotal,
    this.totalAmount,
    this.totalFine,
    this.totalPaid,
    this.grandTotal,
    this.dueBalance,
    this.totalWaiver, this.status,
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
                        child:  Text(
                          "View".tr,
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            onTap: onViewInvoiceTap,
                            child:  Text("View Invoice".tr),
                          ),
                          if(status != "Paid" ) PopupMenuItem(
                            value: 2,
                            onTap: onAddPaymentTap,
                            child:  Text("Add Payment".tr),
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
                    title: "Amount".tr,
                    value: amount,
                  ),
                  ColumnTile(
                    title: "Paid".tr,
                    value: paid,
                  ),
                  ColumnTile(
                    title: isInvoice ? "Fine".tr : "Balance".tr,
                    value: isInvoice ? fine : balance,
                  ),
                  isInvoice
                      ? Flexible(
                          child: ColumnTile(
                            title: "Waiver".tr,
                            value: waiver,
                          ),
                        )
                      : Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "Status".tr,
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
                title: isInvoice ? "Sub Total".tr : "Due Date".tr,
                value: isInvoice ? subTotal : dueDate,
              ),
              10.verticalSpacing,
              const CustomDivider(
                color: AppColors.customDividerColor,
              )
            ],
          ),
          10.verticalSpacing,
          isInvoice
              ? Column(
                children: [
                  TwoValueTile(
                    title: "Total Amount".tr,
                    amount: totalAmount,
                  ),
                  TwoValueTile(
                    title: "Total Waiver".tr,
                    amount: totalWaiver,
                  ),
                  TwoValueTile(
                    title: "Total Fine".tr,
                    amount: totalFine,
                  ),
                  TwoValueTile(
                    title: "Total Paid".tr,
                    amount: totalPaid,
                  ),
                  TwoValueTile(
                    title: "Grand Total".tr,
                    amount: grandTotal,
                  ),
                  5.verticalSpacing,
                  TwoValueTile(
                    title: "Due Balance".tr,
                    amount: dueBalance,
                    isDueBalance: true,
                  ),
                ],
              )
              : const SizedBox()
        ],
      ),
    );
  }
}
