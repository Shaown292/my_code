import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment() async {
    try {

      paymentIntent = await createPaymentIntent('100', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();

      print('try::::::::');
    } catch (e, t) {
      print('catch::::::::');
      print(e);
      print(t);
    }
  }

  displayPaymentSheet() async {
    try {
      print('display::::::::');
      await Stripe.instance.presentPaymentSheet().then((value) {

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
            )
        );

        // showDialog(
        //     context: Get.context,
        //     builder: (_) => const AlertDialog(
        //       content: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Icon(
        //             Icons.check_circle,
        //             color: Colors.green,
        //             size: 100.0,
        //           ),
        //           SizedBox(height: 10.0),
        //           Text("Payment Successful!"),
        //         ],
        //       ),
        //     ));
        print('Payment Intent ::::: $paymentIntent');

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
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
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51OTydVHHgGZ1rB2oIpSFP0VPpk92x5vXBC30rGfbjITnq3IfjSYZRqOQ78sqTqEX7opbWgqxGxQkPOWbIjUbmBtL00kbanmzce',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

}