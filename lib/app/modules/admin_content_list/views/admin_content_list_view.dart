import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_content_list_controller.dart';
import 'widget/content_tile.dart';

class AdminContentListView extends GetView<AdminContentListController> {
  const AdminContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Content List",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                  itemBuilder: (context, index){
                return  ContentTile(
                  title: "New Assignment",
                  contentType: "Assignment",
                  date: "30-03-2023",
                  availableFor: "Student",
                  onDeleteTap: ()=> debugPrint("Item deleted"),
                  onDownloadTap: ()=> debugPrint("Item downloaded"),
                );
              }),
              50.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
