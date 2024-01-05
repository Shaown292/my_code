import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat/views/widget/chat_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/blocked_users_controller.dart';

class BlockedUsersView extends GetView<BlockedUsersController> {
  const BlockedUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Blocked Users",
      body: CustomBackground(
        customWidget: Obx(
          () => Column(
            children: [
              20.verticalSpacing,
              Expanded(
                child: controller.blockedUsersDataLoader.value
                    ? const SecondaryLoadingWidget()
                    : controller.blockedUsersData.isNotEmpty ? ListView.builder(
                        itemCount: controller.blockedUsersData.length,
                        itemBuilder: (context, index) {
                          return ChatTile(
                            profileImageUrl:
                                controller.blockedUsersData[index].image,
                            name: controller.blockedUsersData[index].fullName,
                            onTapUnblock: () => controller.blockSingleUser(
                                type: "",
                                userId:
                                    controller.blockedUsersData[index].userId!),
                            isBlocked: true,
                          );
                        }) : const NoDataAvailableWidget(
                  message: "No block user found",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
