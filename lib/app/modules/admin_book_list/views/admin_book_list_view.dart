import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_book_list_controller.dart';

class AdminBookListView extends GetView<AdminBookListController> {
  const AdminBookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List",
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CustomBackground(
          customWidget: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return BookListTile(
                          bookName: "Horror",
                          subject: "Bangla",
                          bookNumber: "100",
                          onTap: () {
                            controller.showBookListDetailsBottomSheet(
                              index: index,
                              bottomSheetBackgroundColor: Colors.white,
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
