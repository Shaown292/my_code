import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/credit_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/fees_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceView extends GetView<AdminFeesInvoiceController> {
  const AdminFeesInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees Invoice",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 75,
                        child: Image.asset(
                          ImagePath.appLogo,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Invoice No: ${controller.feesController.feesInvoiceInfo?.invoiceId}",
                            style: AppTextStyle.homeworkElements,
                          ),
                          Text(
                            "Created Date: ${controller.feesController.feesInvoiceInfo?.createDate}",
                            style: AppTextStyle.homeworkElements,
                          ),
                          Text(
                            "Due Date: ${controller.feesController.feesInvoiceInfo?.dueDate}",
                            style: AppTextStyle.homeworkElements,
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpacing,
                  const Text(
                    "Annual Exam Fee",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                  30.verticalSpacing,
                  controller.feesController.feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              controller.feesController.invoiceDetails.length,
                          itemBuilder: (context, index) {
                            return FeesTile(
                              amount: controller
                                  .feesController.invoiceDetails[index].amount,
                              paid: controller.feesController
                                  .invoiceDetails[index].paidAmount,
                              fine: controller
                                  .feesController.invoiceDetails[index].fine,
                              waiver: controller
                                  .feesController.invoiceDetails[index].weaver,
                              subTotal: controller
                                  .feesController.invoiceDetails[index].subTotal,
                              isInvoice: true,
                              totalAmount: controller.feesController
                                  .invoiceDetails[index].totalAmount,
                              totalWaiver: controller
                                  .feesController.invoiceDetails[index].weaver,
                              totalFine: controller
                                  .feesController.invoiceDetails[index].fine,
                              totalPaid: controller.feesController
                                  .invoiceDetails[index].paidAmount,
                              grandTotal: controller.feesController
                                  .invoiceDetails[index].grandTotal,
                              dueBalance: controller.feesController
                                  .invoiceDetails[index].dueBalance,
                            );
                          }),
                  controller.feesController.feesInvoiceLoader.value
                      ? const SecondaryLoadingWidget()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.feesController.banks.length,
                          itemBuilder: (context, index) {
                            return CreditCard(
                              bankName: controller
                                      .feesController.banks[index].bankName ??
                                  "",
                              accountNumber: controller.feesController
                                      .banks[index].accountNumber ??
                                  "",
                              accountName: controller
                                      .feesController.banks[index].accountName ??
                                  "",
                              type: controller
                                      .feesController.banks[index].accountType ??
                                  "",
                            );
                          }),
                  30.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
