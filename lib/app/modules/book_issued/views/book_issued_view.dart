import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

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
              Container(
                height: Get.height * 0.07,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: AppColors.profileCardBackgroundColor,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.12,
                      child: const Text(
                        "Book No",
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                    Container(
                      width: Get.width * 0.2,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "Subject",
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                    const Text(
                      "Book Name",
                      style: AppTextStyle.textStyle12WhiteW500,
                    )
                  ],
                ),
              ),
              10.verticalSpacing,
              Obx(
                () => controller.loadingController.isLoading
                    ? const Expanded(
                        child: LoadingWidget(),
                      )
                    : Expanded(
                        child: controller.isMembershipAvailable.value == true
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller.memberShipMessage.value,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.red,
                                        letterSpacing: 2),
                                  ),
                                ),
                              )
                            : controller.studentIssuedBookList.isEmpty
                                ? const NoDataAvailableWidget()
                                : ListView.builder(
                                    itemCount: controller.studentIssuedBookList.length,
                                    itemBuilder: (context, index) {
                                      return BookListTile(
                                        bookNumber: controller.studentIssuedBookList[index].bookNumber,
                                        bookName: controller.studentIssuedBookList[index].bookTitle,
                                        subject: controller.studentIssuedBookList[index].subject,
                                        view: "Details",
                                        onTap: () => controller
                                            .showBookListDetailsBottomSheet(
                                          index: index,
                                          bottomSheetBackgroundColor:
                                              Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
