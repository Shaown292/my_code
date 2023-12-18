import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/delete_tile/delete_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_route_controller.dart';

class AdminRouteView extends GetView<AdminRouteController> {
  const AdminRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: InfixEduScaffold(
        title: "Route",
        body: CustomBackground(
          customWidget: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TabBar(
                  labelColor: AppColors.profileValueColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
                  indicatorColor: AppColors.profileIndicatorColor,
                  controller: controller.tabController,
                  tabs: List.generate(
                    controller.tabs.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        controller.tabs[index],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: controller.routeTitleTextController,
                            enableBorderActive: true,
                            focusBorderActive: true,
                            hintText: "Route Title",
                            hintTextStyle:
                                AppTextStyle.fontSize14lightBlackW400,
                            fillColor: Colors.white,
                          ),
                          10.verticalSpacing,
                          CustomTextFormField(
                            controller: controller.routeFareTextController,
                            textInputType: TextInputType.number,
                            enableBorderActive: true,
                            focusBorderActive: true,
                            hintText: "Route fare",
                            hintTextStyle:
                                AppTextStyle.fontSize14lightBlackW400,
                            fillColor: Colors.white,
                          ),
                          30.verticalSpacing,
                          Obx(
                            () => controller.saveLoader.value
                                ? const CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  )
                                : PrimaryButton(
                                    text: "Save",
                                    onTap: () {
                                      if (controller.validation()) {
                                        controller.addTransportRoute();
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),

                    /// Route List
                    Obx(
                      () => controller.loadingController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ))
                          : controller.adminTransportRouteList.isNotEmpty
                              ? RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async {
                          controller.adminTransportRouteList.clear();
                          controller.getAdminTransportRouteList();
                        },
                                child: ListView.builder(
                                    itemCount:
                                        controller.adminTransportRouteList.length,
                                    itemBuilder: (context, index) {
                                      return DeleteTile(
                                        title:
                                            "${index + 1}. Route Title: ${controller.adminTransportRouteList[index].title}",
                                        subTitle:
                                            "Fare: ${controller.adminTransportRouteList[index].fare.toString()}",

                                        /// Delete button
                                        rightIconBackgroundColor:
                                            const Color(0xFFED3B3B),
                                        rightIcon: ImagePath.delete,
                                        tapRightButton: () => Get.dialog(
                                          Obx(
                                            () => CustomPopupDialogue(
                                              isLoading:
                                                  controller.deleteLoader.value,
                                              onYesTap: () {
                                                controller.deleteSingleRoute(
                                                    routeId: controller
                                                        .adminTransportRouteList[
                                                            index]
                                                        .id!,
                                                    index: index);
                                              },
                                              title: 'Confirmation',
                                              subTitle: AppText
                                                  .deleteFeesGroupWarningMsg,
                                              noText: 'cancel',
                                              yesText: 'delete',
                                            ),
                                          ),
                                        ),

                                        /// Edit button
                                        leftIcon: ImagePath.edit,
                                        leftIconBackgroundColor:
                                            AppColors.appButtonColor,
                                        tapLeftButton: () {
                                          controller.routeTitleTextController
                                              .text = controller
                                                  .adminTransportRouteList[index]
                                                  .title ??
                                              '';
                                          controller
                                                  .routeFareTextController.text =
                                              controller
                                                  .adminTransportRouteList[index]
                                                  .fare
                                                  .toString();
                                          controller
                                              .showUploadDocumentsBottomSheet(
                                            routeId: controller
                                                .adminTransportRouteList[index]
                                                .id!,
                                            index: index,
                                            bottomSheetBackgroundColor: Colors.white,
                                            header: "Edit Route",
                                          );
                                        },
                                      );
                                    },
                                  ),
                              )
                              : const NoDataAvailableWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
