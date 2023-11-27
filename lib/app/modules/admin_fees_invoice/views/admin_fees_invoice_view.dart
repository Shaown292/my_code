import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceView extends GetView<AdminFeesInvoiceController> {
  const AdminFeesInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Fees Invoice",
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: (){},
            child: const Icon(Icons.search, color: Colors.white,),
          ),
        )
      ],
      body: const CustomBackground(
        customWidget: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
