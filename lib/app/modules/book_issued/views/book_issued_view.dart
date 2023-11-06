import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_issued/views/widget/issued_book_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../controllers/book_issued_controller.dart';

class BookIssuedView extends GetView<BookIssuedController> {
  const BookIssuedView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book Issued",
      body: SingleChildScrollView(
        child: CustomBackground(
          customWidget: Column(
            children: [
              10.verticalSpacing,
              Obx(() => Expanded(
                child: controller.loadingController.isLoading ? const LoadingWidget() : ListView.builder(
                    itemCount: 5, itemBuilder: (context, index) {
                  return const IssuedBookTile(
                    issuedDate: "10-03-2023",
                    returnDate: "11-03-2023",
                    bookName: "Mathematics 102",
                    bookNo: "10",
                    activeStatus: "Returned",
                    activeStatusColor: Colors.redAccent,

                  );
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
