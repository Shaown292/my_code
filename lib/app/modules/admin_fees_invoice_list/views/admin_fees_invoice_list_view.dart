import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_fees_invoice_list/views/widget/admin_fees_invoice_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_list_controller.dart';

class AdminFeesInvoiceListView extends GetView<AdminFeesInvoiceListController> {
  const AdminFeesInvoiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees Invoice",
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        )
      ],
      body: CustomBackground(
        customWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getFeesInvoiceList();
                  },
                  child: controller.loadingController.isLoading
                      ? const Column(
                          children: [
                            LoadingWidget(),
                          ],
                        )
                      : controller.feesInvoiceList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.feesInvoiceList.length,
                              itemBuilder: (context, index) {
                                return AdminFeesInvoiceTile(
                                  studentName: controller
                                      .feesInvoiceList[index].fullName,
                                  studentClass: controller
                                      .feesInvoiceList[index].studentClass,
                                  studentSection:
                                      controller.feesInvoiceList[index].section,
                                  date: controller.feesInvoiceList[index].date,
                                  amount:
                                      controller.feesInvoiceList[index].amount,
                                  paid: controller.feesInvoiceList[index].paid,
                                  balance:
                                      controller.feesInvoiceList[index].balance,
                                  status:
                                      controller.feesInvoiceList[index].status,
                                  statusColor: AppColors.activeStatusRedColor,
                                  onTapView: () =>
                                      Get.toNamed(Routes.ADMIN_FEES_INVOICE),
                                  onTapDelete: (() => controller.showAlertDialog()),
                                );
                              },
                            )
                          : const NoDataAvailableWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
