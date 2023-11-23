import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/delete_tile/delete_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_type_controller.dart';

class AdminFeesTypeView extends GetView<AdminFeesTypeController> {
  const AdminFeesTypeView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees Type",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async{
                },
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return DeleteTile(
                      title: "${index + 1} Hello",

                      /// Delete button
                      rightIconBackgroundColor: const Color(0xFFED3B3B),
                      rightIcon: ImagePath.delete,
                      tapRightButton: () => Get.dialog(
                        CustomPopupDialogue(
                          onYesTap: () {},
                          title: 'Confirmation',
                          subTitle: AppText.deleteFeesTypeWarningMsg,
                          noText: 'cancel',
                          yesText: 'delete',
                        ),
                      ),

                      /// Edit button
                      leftIcon: ImagePath.edit,
                      leftIconBackgroundColor: AppColors.appButtonColor,
                      tapLeftButton: () {
                        controller.showUploadDocumentsBottomSheet(
                          header: "Edit",
                          bottomSheetBackgroundColor: Colors.white,
                          titleController: controller.titleTextController,
                          descriptionController: controller.descriptionTextController,
                          onTapCancel: (){
                            Get.back();
                            controller.titleTextController.clear();
                            controller.descriptionTextController.clear();
                          },
                          onTapForSave: () {},
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          controller.showUploadDocumentsBottomSheet(
            header: "Add Fees Group",
            bottomSheetBackgroundColor: Colors.white,
            titleController: controller.titleTextController,
            descriptionController: controller.descriptionTextController,
            onTapCancel: (){
              Get.back();
              controller.titleTextController.clear();
              controller.descriptionTextController.clear();
            },
            onTapForSave: () {
              debugPrint("Title :::: ${controller.titleTextController}");
              debugPrint("Description :::: ${controller.descriptionTextController}");
            },
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
