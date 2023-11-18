import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/fees_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/colum_tile/column_tile.dart';
import '../controllers/fees_controller.dart';

class FeesView extends GetView<FeesController> {
  const FeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees",
      leadingIcon: const SizedBox(),
      body: CustomBackground(
        customWidget: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Grand Total",
                      style: AppTextStyle.homeworkSubject,
                    ),
                    20.verticalSpacing,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ColumnTile(
                              title: "Amount",
                              value: controller.invoiceDetails[0].totalAmount,
                              width: Get.width * 0.17,
                            ),
                            ColumnTile(
                              title: "Discount",
                              value: controller.invoiceDetails[0].totalWaiver,
                              width: Get.width * 0.17,
                            ),
                            ColumnTile(
                              title: "Fine",
                              value: controller.invoiceDetails[0].totalFine,
                              width: Get.width * 0.17,
                            ),
                            ColumnTile(
                              title: "Paid",
                              value: controller.invoiceDetails[0].totalPaid,
                              width: Get.width * 0.17,
                            ),
                            ColumnTile(
                              title: "Balance",
                              value: controller.invoiceDetails[0].dueBalance,
                              width: Get.width * 0.17,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return FeesTile(
                    statusText: "Paid",
                    statusColor: Colors.green,
                    dueDate: "10-12-2023",
                    duration: "Monthly",
                    amount: "10",
                    paid: "8",
                    balance: "2",
                    onTap: () {
                      controller.showFeesDetailsBottomSheet(index: index);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
