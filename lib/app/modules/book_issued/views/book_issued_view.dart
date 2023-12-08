import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_status_tile/show_status_tile.dart';
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
              controller.loadingController.isLoading
                  ? const Expanded(
                child: LoadingWidget(),
              )
                  : Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShowStatusTile(
                        firstTitle: "10-03-2023",
                        secondTitle: "11-03-2023",
                        firstValue: "Mathematics 102",
                        thirdTitle: "10",
                        activeStatus: "Returned",
                        activeStatusColor: Colors.redAccent,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
