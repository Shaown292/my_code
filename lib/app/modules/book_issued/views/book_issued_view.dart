import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/book_issued_controller.dart';

class BookIssuedView extends GetView<BookIssuedController> {
  const BookIssuedView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Book Issued",
      body: SingleChildScrollView(
        child: CustomBackground(
          customWidget: Column(
            children: [
              Text("Title"),
              Text("Issued Date"),
              Text("Return Date"),
              Text("Book no"),
              Text("Status"),
            ],
          ),
        ),
      ),
    );
  }
}
