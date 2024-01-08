import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_book_list_controller.dart';

class AdminBookListView extends GetView<AdminBookListController> {
  const AdminBookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List".tr,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getAdminBookList();
        },
        child: CustomBackground(
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.1,
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
                      child:  Text(
                        "Book No".tr,
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
                      child:  Text(
                        "Subject".tr,
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                     Text(
                      "Book Name".tr,
                      style: AppTextStyle.textStyle12WhiteW500,
                    )
                  ],
                ),
              ),
              Obx(
                () => Expanded(
                  child: controller.loadingController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : controller.bookList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.bookList.length,
                              itemBuilder: (context, index) {
                                return BookListTile(
                                  bookName:
                                      controller.bookList[index].bookTitle,
                                  subject:
                                      controller.bookList[index].subjectName,
                                  bookNumber:
                                      controller.bookList[index].bookNumber,
                                  onTap: () {
                                    controller.showBookListDetailsBottomSheet(
                                      index: index,
                                      bottomSheetBackgroundColor:
                                          Colors.white,
                                    );
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
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
