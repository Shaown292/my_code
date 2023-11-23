import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceView extends GetView<AdminFeesInvoiceController> {
  const AdminFeesInvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminFeesInvoiceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminFeesInvoiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
