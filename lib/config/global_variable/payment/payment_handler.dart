import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/controllers/fees_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_wallet/controllers/student_wallet_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student/wallet/payment_handler/payment_response_model.dart';
import 'package:get/get.dart';

class PaymentHandlerController extends GetxController {
  Future<PaymentResponseModel> paymentSuccessHandler({
    required String type,
    required double amount,
    required int paymentMethod,
    int? invoiceId,
    required String from,
  }) async {
    try {
      final response = await BaseClient().postData(
          url: InfixApi.paymentHandler,
          header: GlobalVariable.header,
          payload: {
            "type": from,
            "amount": amount,
            "payment_method": paymentMethod,
            "fees_invoice_id": invoiceId,
          });

      PaymentResponseModel responseModel =
          PaymentResponseModel.fromJson(response);

      if (responseModel.success == true) {
        showBasicSuccessSnackBar(message: responseModel.message!);

        if (from == 'feesInvoice') {
          Get.find<FeesController>().getAllFeesList(
            studentId: Get.find<GlobalRxVariableController>().studentId.value!,
            recordId:
                Get.find<GlobalRxVariableController>().studentRecordId.value!,
          );
        } else if (from == 'walletAddBallence') {
          Get.find<StudentWalletController>().getPaymentDetails();
        }
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}

    return PaymentResponseModel();
  }
}
