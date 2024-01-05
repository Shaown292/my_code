import 'dart:convert';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/payment/payment_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class StripeController extends GetxController {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment({required String amount, required String currency, required String type, required int paymentMethod, required int invoiceId,}) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), currency);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay',
            ),
          )
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(amount: amount, type: type, paymentMethod: paymentMethod, invoiceId: invoiceId,);
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  displayPaymentSheet({required String amount, required String type, required int paymentMethod, required int invoiceId,}) async {
    PaymentHandlerController paymentHandlerController = Get.put(PaymentHandlerController());
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {

        Get.dialog(
            barrierDismissible: false,
            Dialog(
              backgroundColor: Colors.white,
              child: WillPopScope(
                onWillPop: () async => false,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ),
              ),
            )).then((value) => paymentHandlerController.paymentSuccessHandler(
          type: type,
          amount: double.tryParse(amount)!,
          paymentMethod: paymentMethod,
          invoiceId: invoiceId,
        ));



        print('Payment Intent ::::: ${paymentIntent?['id']}');

        // Delay for 2 seconds and then close the alert dialog
        await Future.delayed(const Duration(seconds: 2));

        // Close the alert dialog
        Get.back();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      debugPrint('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse(AppConfig.stripeServerURL),
        headers: {
          'Authorization':
              'Bearer ${AppConfig.stripeToken}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;

    return calculatedAmount.toString();
  }
}
