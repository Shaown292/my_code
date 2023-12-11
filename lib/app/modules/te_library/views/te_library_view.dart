import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/book_list_tile/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_library_controller.dart';

class TeLibraryView extends GetView<TeLibraryController> {
  const TeLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Book List",
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: CustomBackground(
            customWidget: Column(
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return BookListTile(
                        bookName: "Book Name",
                        subject: "Subject",
                        bookNumber: "101",
                        onTap: () {
                          controller.showBookListDetailsBottomSheet(
                            index: index,
                            bottomSheetBackgroundColor: Colors.white,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
