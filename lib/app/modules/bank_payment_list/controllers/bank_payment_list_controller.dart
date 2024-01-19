import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_fees_model/bank_payment_list_response_model.dart';
import 'package:get/get.dart';

class BankPaymentListController extends GetxController {


  RxList<ApproveList> approveList = <ApproveList>[].obs;
  RxList<PendingList> pendingList = <PendingList>[].obs;
  RxList<RejectList> rejectList = <RejectList>[].obs;
  RxBool isLoading = false.obs;

  TabController? tabController;

  List<String> status = <String>[
    'Pending'.tr,
    'Approved'.tr,
    'Rejected'.tr,
  ];

  Future<BankPaymentListResponseModel?> getAllBankPaymentList() async {
    try {
      isLoading.value = true;

      final response = await BaseClient().getData(
        url:  InfixApi.getBankPaymentList,
        header: GlobalVariable.header,
      );

      BankPaymentListResponseModel bankPaymentListResponseModel = BankPaymentListResponseModel.fromJson(response);
      if (bankPaymentListResponseModel.success == true) {
        isLoading.value = false;
        if (bankPaymentListResponseModel.data!.first.approve!.isNotEmpty) {
          for (int i = 0;
          i < bankPaymentListResponseModel.data!.first.approve!.length;
          i++) {
            approveList.add(bankPaymentListResponseModel.data!.first.approve![i]);
          }
        }
        if (bankPaymentListResponseModel.data!.first.pending!.isNotEmpty) {
          for (int i = 0;
          i < bankPaymentListResponseModel.data!.first.pending!.length;
          i++) {
            pendingList.add(bankPaymentListResponseModel.data!.first.pending![i]);
          }
        }
        if (bankPaymentListResponseModel.data!.first.reject!.isNotEmpty) {
          for (int i = 0;
          i < bankPaymentListResponseModel.data!.first.reject!.length;
          i++) {
            rejectList.add(bankPaymentListResponseModel.data!.first.reject![i]);
          }
        }




      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
    return BankPaymentListResponseModel();
  }
  @override
  void onInit() {
    getAllBankPaymentList();
    super.onInit();
  }
}
