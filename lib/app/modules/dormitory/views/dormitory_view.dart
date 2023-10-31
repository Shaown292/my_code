import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/dormitory/views/widget/dormitory_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/dormitory_controller.dart';

class DormitoryView extends GetView<DormitoryController> {
  const DormitoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Dormitory",
      body: CustomBackground(
        customWidget: Obx(() => Column(
              children: [
                controller.loadingController.isLoading
                    ? const LoadingWidget()
                    : controller.dormitoryList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.dormitoryList.length,
                              itemBuilder: (context, index) {
                                return DormitoryCardTile(
                                  hostelType: controller
                                      .dormitoryList[index].dormitoryName,
                                  roomNo: controller
                                      .dormitoryList[index].roomNumber,
                                  numberOfBed: controller
                                      .dormitoryList[index].numberOfBed,
                                  cost: controller
                                      .dormitoryList[index].costPerBed,
                                  activeStatus:
                                      controller.dormitoryList[index].status,
                                );
                              },
                            ),
                          )
                        : const NoDataAvailableWidget(),
              ],
            )),
      ),
    );
  }
}
