import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_book_controller.dart';

class AdminAddBookView extends GetView<AdminAddBookController> {
  const AdminAddBookView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Add Book",
      body: CustomBackground(
        customWidget: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
