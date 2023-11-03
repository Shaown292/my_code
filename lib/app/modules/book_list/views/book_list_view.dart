import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_list/views/widget/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List",
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CustomBackground(
          customWidget: Obx(()=> RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async{
              controller.bookListData.clear();
              controller.getAllBookList();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.loadingController.isLoading ? const LoadingWidget() :
                controller.bookListData.isNotEmpty ?
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.bookListData.length,
                      itemBuilder: (context, index) {
                        return BookListTile(
                          bookName: controller.bookListData[index].bookTitle,
                          subject: controller.bookListData[index].subject,
                          bookNumber: controller.bookListData[index].bookNumber,

                        );
                      }),
                ) : const NoDataAvailableWidget(),
              ],
            ),
          ),),
        ),
      ),
    );
  }
}
