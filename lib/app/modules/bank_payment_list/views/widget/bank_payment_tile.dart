import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class BankPaymentTile extends StatelessWidget {
  final Color? color;
  final Function()? onTap;
  final String? studentName;
  final String? date;
  final String? amount;
  final String? status;
  final Color? statusColor;

  const BankPaymentTile({
    super.key,
    this.color,
    this.onTap,
    this.studentName, this.date, this.amount, this.status, this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Column(
                    children: [
                      Text(
                        "View".tr,
                        style: AppTextStyle.homeworkView,
                      ),
                      const CustomDivider(
                        width: 35,
                        height: 1,
                        color: AppColors.homeworkViewColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.verticalSpacing,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnTile(
                  title: "Student Name".tr,
                  value: studentName,
                  width: Get.width * 0.25,
                ),
                ColumnTile(
                  title: "Date".tr,
                  value: date,
                  width: Get.width * 0.2,
                ),
                ColumnTile(
                  title: "Amount".tr,
                  value: amount,
                  width: Get.width * 0.2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status".tr,
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                    15.verticalSpacing,
                    status != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: statusColor),
                            child: Center(
                              child: Text(
                                status ?? "",
                                style: AppTextStyle.textStyle10WhiteW400,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
