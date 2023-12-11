import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/content_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../controllers/te_content_list_controller.dart';

class TeContentListView extends GetView<TeContentListController> {
  const TeContentListView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Content List",
      body: CustomBackground(
        customWidget: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {

          },
          child: Column(
            children: [
              Obx(
                    () => controller.loadingController.isLoading
                    ? const Expanded(
                  child: LoadingWidget(),
                )
                    :  Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ContentTile(
                        title: "Title",
                        contentType: "Assignment",
                        date: "21-03-2023",
                        availableFor: "All Student",
                        onDeleteTap: () {} ,
                        onDownloadTap: () {},
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
