import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/delete_tile/delete_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

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
            Obx(() =>
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () async {
                      controller.getFeesListList();
                    },
                    child: controller.loadingController.isLoading
                        ? const Column(
                      children: [
                        LoadingWidget(),
                      ],
                    )
                        : controller.feesTypeList.isNotEmpty ? ListView.builder(
                      itemCount: controller.feesTypeList.length,
                      itemBuilder: (context, index) {
                        return DeleteTile(
                          title: "${index + 1}. ${controller.feesTypeList[index]
                              .name}",
                          subTitle: controller.feesTypeList[index].description,

                          /// Delete button
                          rightIconBackgroundColor: const Color(0xFFED3B3B),
                          rightIcon: ImagePath.delete,
                          tapRightButton: () =>
                              Get.dialog(
                                Obx(() =>
                                    CustomPopupDialogue(
                                      isLoading: controller.deleteLoader.value,
                                      onYesTap: () {
                                        controller.deleteSingleFeesType(
                                            feesTypeId: controller
                                                .feesTypeList[index].id!,
                                            index: index);
                                      },
                                      title: 'Confirmation',
                                      subTitle: AppText
                                          .deleteFeesTypeWarningMsg,
                                      noText: 'cancel',
                                      yesText: 'delete',
                                    ),),
                              ),

                          /// Edit button
                          leftIcon: ImagePath.edit,
                          leftIconBackgroundColor: AppColors.appButtonColor,
                          tapLeftButton: () {
                            controller.titleTextController.text =
                                controller.feesTypeList[index].name ??
                                    '';
                            controller.descriptionTextController.text =
                                controller.feesTypeList[index]
                                    .description ??
                                    '';
                            controller.showUploadDocumentsBottomSheet(
                              header: "Edit",
                              bottomSheetBackgroundColor: Colors.white,
                              titleController: controller.titleTextController,
                              descriptionController: controller
                                  .descriptionTextController,
                              onTapCancel: () {
                                Get.back();
                                controller.titleTextController.clear();
                                controller.descriptionTextController.clear();
                              },
                              onTapForSave: () {
                                if (controller.titleTextController.text
                                    .isNotEmpty) {
                                  controller.updateSingleFeesType(
                                    feesGroupId: controller
                                        .adminFeesGroupController.groupId
                                        .value,feesTypeId: controller.feesTypeList[index].id!, index: index);
                                }
                              },
                            );
                          },
                        );
                      },
                    ) : const NoDataAvailableWidget(),
                  ),
                ),),
            40.verticalSpacing,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          debugPrint(
              "Group value :::::::: ${controller.feesTypeInitialValue.value}");
          controller.showUploadDocumentsBottomSheet(
            header: "Add Fees Type",
            bottomSheetBackgroundColor: Colors.white,
            titleController: controller.titleTextController,
            descriptionController: controller.descriptionTextController,
            onTapCancel: () {
              Get.back();
              controller.titleTextController.clear();
              controller.descriptionTextController.clear();
            },
            onTapForSave: () {
              if (controller.titleTextController.text.isEmpty) {
                showBasicFailedSnackBar(message: "Add title");
              }
              else {
                controller.createFeesType(
                    feesGroupId: controller.adminFeesGroupController.groupId
                        .value);
              }
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
