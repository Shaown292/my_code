import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/payment/payment_handler.dart';
import 'package:get/get.dart';

class PayStackController extends GetxController{

  PaymentHandlerController paymentHandlerController = Get.put(PaymentHandlerController());
  final plugin = PaystackPlugin();


  Future<void> makePayment({required String amount, required String currency, required String type, required int paymentMethod, required int invoiceId,}) async {

    final finalAmount = (double.parse(amount) * 100).toInt();
    Charge charge = Charge()
      ..amount = finalAmount
      ..currency = AppConfig.payStackCurrency
      ..reference = invoiceId.toString()
      ..email = 'spn107@spondonit.com';

    CheckoutResponse response = await plugin.checkout(
      Get.context!,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.status == true) {
      print('Response ::::::::: $response');
              paymentHandlerController.paymentSuccessHandler(
          type: 'feesInvoice',
          amount: double.tryParse(amount)!,
          paymentMethod: paymentMethod,
          invoiceId: invoiceId,
        );
    } else {
      print('Response ::::::::: $response');
      showBasicFailedSnackBar(message: response.message.toString(),);
    }



  }

@override
  void onInit() {
  plugin.initialize(publicKey: AppConfig.payStackPublicKey);
    super.onInit();
  }

}