import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/transport/views/widget/transport_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../controllers/transport_controller.dart';

class TransportView extends GetView<TransportController> {
  const TransportView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Transport".tr,
      body: SingleChildScrollView(
        child: CustomBackground(
          customWidget: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              controller.transportDataList.clear();
              controller.getAllTransportList(
                studentId:
                    controller.globalRxVariableController.studentId.value!,
              );
            },
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    color: AppColors.profileCardBackgroundColor,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.13,
                        child:  Text(
                          "Vehicle".tr,
                          style: AppTextStyle.textStyle12WhiteW500,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                        child: const VerticalDivider(
                          color: AppColors.profileTitleColor,
                          thickness: 1,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        padding: const EdgeInsets.all(10),
                        child:  Text(
                          "Status".tr,
                          style: AppTextStyle.textStyle12WhiteW500,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                        child: const VerticalDivider(
                          color: AppColors.profileTitleColor,
                          thickness: 1,
                        ),
                      ),
                       Text(
                        "Route".tr,
                        style: AppTextStyle.textStyle12WhiteW500,
                      )
                    ],
                  ),
                ),
                Obx(
                  () => controller.loadingController.isLoading
                      ? const Expanded(
                          child: LoadingWidget(),
                        )
                      : controller.transportDataList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.transportDataList.length,
                                itemBuilder: (context, index) {
                                  return TransportTile(
                                    vehicle: controller
                                        .transportDataList[index].vehicle,
                                    status: controller
                                        .transportDataList[index].status,
                                    route: controller
                                        .transportDataList[index].route,
                                    tileBackgroundColor: Colors.white,
                                    onTap: () => controller
                                        .showTransportDetailsBottomSheet(
                                            index: index,
                                            bottomSheetBackgroundColor:
                                                Colors.white),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
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
