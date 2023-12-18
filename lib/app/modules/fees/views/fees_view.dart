import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/controllers/fees_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/fees_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

class FeesView extends GetView<FeesController> {
  const FeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Fees",
        leadingIcon: const SizedBox(),
        body: SingleChildScrollView(
          child: CustomBackground(
            customWidget: RefreshIndicator(
              onRefresh: () async {
                controller.getAllFeesList(
                  studentId:
                      controller.globalRxVariableController.studentId.value!,
                  recordId: controller
                      .globalRxVariableController.studentRecordId.value!,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.homeController.loadingController.isLoading
                      ? const LoadingWidget()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 0),
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .homeController.studentRecordList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StudyButton(
                                      title:
                                          "Class ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                      onItemTap: () {
                                        controller.selectIndex.value = index;
                                        controller.recordId.value = controller
                                            .homeController
                                            .studentRecordList[index]
                                            .id;
          
                                        controller.getAllFeesList(
                                            studentId: controller
                                                .globalRxVariableController
                                                .studentId
                                                .value!,
                                            recordId:
                                                controller.recordId.toInt());
                                      },
                                      isSelected:
                                          controller.selectIndex.value == index,
                                    ));
                              },
                            ),
                          ),
                        ),
                  Expanded(
                    child: controller.feesInvoiceList.isEmpty &&
                            controller.feesLoader.value == false
                        ? const Center(child: NoDataAvailableWidget())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.feesInvoiceList.length,
                            itemBuilder: (context, index) {
                              return FeesTile(
                                statusText:
                                    controller.feesInvoiceList[index].status,
                                statusColor: Colors.green,
                                dueDate:
                                    controller.feesInvoiceList[index].createDate,
                                duration: "Monthly",
                                amount: controller.feesInvoiceList[index].amount,
                                paid:
                                    controller.feesInvoiceList[index].paidAmount,
                                balance:
                                    controller.feesInvoiceList[index].balance,
                                onTap: () {
                                  controller.showFeesDetailsBottomSheet(
                                    index: index,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Card(
//   elevation: 5,
//   margin: EdgeInsets.zero,
//   child: Container(
//     padding: const EdgeInsets.all(20),
//     decoration: const BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(8),
//         topRight: Radius.circular(8),
//       ),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Grand Total",
//           style: AppTextStyle.homeworkSubject,
//         ),
//         20.verticalSpacing,
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ColumnTile(
//                   title: "Amount",
//                   value: controller.invoiceDetails[0].totalAmount,
//                   width: Get.width * 0.17,
//                 ),
//                 ColumnTile(
//                   title: "Discount",
//                   value: controller.invoiceDetails[0].totalWaiver,
//                   width: Get.width * 0.17,
//                 ),
//                 ColumnTile(
//                   title: "Fine",
//                   value: controller.invoiceDetails[0].totalFine,
//                   width: Get.width * 0.17,
//                 ),
//                 ColumnTile(
//                   title: "Paid",
//                   value: controller.invoiceDetails[0].totalPaid,
//                   width: Get.width * 0.17,
//                 ),
//                 ColumnTile(
//                   title: "Balance",
//                   value: controller.invoiceDetails[0].dueBalance,
//                   width: Get.width * 0.17,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
