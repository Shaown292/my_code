import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_fees_model/admin_fees_invoice_list_response_model.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceListController extends GetxController {
  LoadingController loadingController = Get.find();

  RxList<StudentInvoices> feesInvoiceList = <StudentInvoices>[].obs;

  Future<AdminFeesInvoiceListResponseModel> getFeesInvoiceList() async {
    try {
      feesInvoiceList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminFeesInvoiceList, header: GlobalVariable.header);

      AdminFeesInvoiceListResponseModel adminFeesInvoiceListResponseModel =
          AdminFeesInvoiceListResponseModel.fromJson(response);

      if (adminFeesInvoiceListResponseModel.success == true) {
        loadingController.isLoading = false;

        if (adminFeesInvoiceListResponseModel
            .data!.studentInvoices!.isNotEmpty) {
          for (int i = 0;
              i <
                  adminFeesInvoiceListResponseModel
                      .data!.studentInvoices!.length;
              i++) {
            feesInvoiceList.add(
                adminFeesInvoiceListResponseModel.data!.studentInvoices![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: adminFeesInvoiceListResponseModel.message ??
                AppText.somethingWentWrong);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminFeesInvoiceListResponseModel();
  }

  void showAlertDialog() {
    Get.dialog(
      CustomPopupDialogue(
        subTitle: 'Are you sure? \nWant to delete?',
        noText: 'Cancel',
        yesText: 'Delete',
        onYesTap: () {
          Get.back();
        },
      ),
    );
  }

  @override
  void onInit() {
    getFeesInvoiceList();
    super.onInit();
  }
}
