import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_fees_invoice_list/views/widget/admin_fees_invoice_tile.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_list_controller.dart';

class AdminFeesInvoiceListView extends GetView<AdminFeesInvoiceListController> {
  const AdminFeesInvoiceListView({Key? key}) : super(key: key);
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {

                },
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return  AdminFeesInvoiceTile(
                      studentName: "Syed Mahtab",
                      studentClass: "Play",
                      studentSection: "Rose",
                      date: "23-10-2023",
                      amount: "100",
                      paid: "50",
                      balance: "50",
                      status: "Paid",
                      statusColor: AppColors.activeStatusRedColor,
                      onTapView: () => Get.toNamed(Routes.ADMIN_FEES_INVOICE),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
