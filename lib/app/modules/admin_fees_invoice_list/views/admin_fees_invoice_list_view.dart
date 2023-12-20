import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_fees_invoice_list/views/widget/admin_fees_invoice_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_list/views/widget/search_field.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_list_controller.dart';

class AdminFeesInvoiceListView extends GetView<AdminFeesInvoiceListController> {
  const AdminFeesInvoiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Fees Invoice",
        body: CustomBackground(
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      controller.loadingController.isLoading
                          ? const SecondaryLoadingWidget()
                          : DuplicateDropdown(
                              dropdownValue: controller
                                      .adminStudentsSearchController
                                      .classList
                                      .isEmpty
                                  ? controller.classNullValue.value
                                  : controller.adminStudentsSearchController
                                      .classValue.value,
                              dropdownList: controller
                                  .adminStudentsSearchController.classList,
                              changeDropdownValue: (v) {
                                controller.adminStudentsSearchController
                                    .classValue.value = v!;
                                controller.adminStudentsSearchController
                                    .studentClassId.value = v.id;
                              },
                            ),
                      20.verticalSpacing,
                      controller.sectionLoader.value
                          ? const SecondaryLoadingWidget()
                          : DuplicateDropdown(
                              dropdownValue: controller
                                      .adminStudentsSearchController
                                      .sectionList
                                      .isEmpty
                                  ? controller.sectionNullValue.value
                                  : controller.adminStudentsSearchController
                                      .sectionValue.value,
                              dropdownList: controller
                                  .adminStudentsSearchController.sectionList,
                              changeDropdownValue: (v) {
                                controller.adminStudentsSearchController
                                    .sectionValue.value = v!;
                                controller.adminStudentsSearchController
                                    .studentSectionId.value = v.id;
                              },
                            )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SearchField(
                  controller: controller.searchController,
                  onChange: (searchKey) {
                    controller.feesInvoiceList.clear();
                    controller.searchFeesInvoice(
                      controller
                          .adminStudentsSearchController.studentClassId.value,
                      controller
                          .adminStudentsSearchController.studentSectionId.value,
                      searchKey,
                    );
                  },
                  hintTextStyle: AppTextStyle.fontSize12GreyW400,
                  icon: controller.searchController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            controller.searchController.clear();
                            controller.feesInvoiceList.clear();
                            controller.getFeesInvoiceList();
                          },
                          child: Icon(
                            Icons.close,
                            color: AppColors.profileDividerColor,
                            size: 20,
                          ),
                        )
                      : Icon(
                          Icons.search,
                          color: AppColors.profileDividerColor,
                          size: 20,
                        ),
                ),
              ),
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.getFeesInvoiceList();
                        },
                        child: controller.feesInvoiceList.isEmpty
                            ? const Center(
                                child: NoDataAvailableWidget(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.feesInvoiceList.length,
                                itemBuilder: (context, index) {
                                  return AdminFeesInvoiceTile(
                                    studentName: controller
                                        .feesInvoiceList[index].fullName,
                                    studentClass: controller
                                        .feesInvoiceList[index].studentClass,
                                    studentSection: controller
                                        .feesInvoiceList[index].section,
                                    date:
                                        controller.feesInvoiceList[index].date,
                                    amount: controller
                                        .feesInvoiceList[index].amount,
                                    paid:
                                        controller.feesInvoiceList[index].paid,
                                    balance: controller
                                        .feesInvoiceList[index].balance,
                                    status: controller
                                        .feesInvoiceList[index].status,
                                    statusColor: AppColors.activeStatusRedColor,
                                    onTapView: () =>
                                        Get.toNamed(Routes.ADMIN_FEES_INVOICE),
                                    onTapDelete: (() =>
                                        controller.showAlertDialog()),
                                  );
                                },
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
