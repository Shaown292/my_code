import 'package:flutter_single_getx_api_v2/app/modules/fees/controllers/fees_controller.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceController extends GetxController {

  FeesController feesController = Get.put(FeesController());

  RxInt invoiceId = 0.obs;

  @override
  void onInit() {
    invoiceId.value = Get.arguments["invoice_id"];
    feesController.getFeesInvoice(invoiceId: invoiceId.value);
    // TODO: implement onInit
    super.onInit();
  }
}
