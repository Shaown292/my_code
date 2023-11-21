import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat/views/widget/chat_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../data/constants/image_path.dart';
import '../../../routes/app_pages.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: controller.chatType.length,
      child: InfixEduScaffold(
        title: "Chat",
        actions: [
          Obx(
            () {

              return SizedBox(
                width: 110,
                child: CustomDropdown(
                  dropdownValue: controller.dropdownValue.value,
                  scheduleList: controller.activeStatus,
                  color: Colors.white,
                  dropdownText: false,
                  changeDropdownValue: (v){
                    controller.dropdownValue.value = v!;
                  },
                  activeStatusColor:  Color(int.parse(controller.changeActiveStatusColor()!)),
                  dropdownColor: AppColors.activeExamStatusBlueColor,
                ),
              );

            }
          ),
          10.horizontalSpacing,
          InkWell(
            onTap: () {
              Get.toNamed(Routes.CHAT_SEARCH);
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          5.horizontalSpacing,
          PopupMenuButton(
            padding: EdgeInsets.zero,
            iconColor: Colors.white,
            onSelected: (value) {
              if (value == 1) {

              }
            },
            itemBuilder: (context) => [
               PopupMenuItem(
                value: 1,
                child: const Text("Blocked Users"),
                onTap: () => Get.toNamed(Routes.BLOCKED_USERS),
              ),
            ],
          ),

        ],
        body: CustomBackground(
          customWidget: Column(
            children: [
              15.verticalSpacing,
              TabBar(
                labelColor: AppColors.profileValueColor,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
                indicatorColor: AppColors.profileIndicatorColor,
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller.tabController,
                tabs: List.generate(
                  controller.chatType.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      controller.chatType[index],
                    ),
                  ),
                ),
              ),
              10.verticalSpacing,
              Obx(
                () => Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      controller.loadingController.isLoading
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {},
                              child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    String colorCode = '';
                                    String status = 'AWAY';
                                    if (status == 'ACTIVE') {
                                      colorCode = '0xFF12AE01';
                                    } else if (status == 'INACTIVE') {
                                      colorCode = '0xFFE1E2EC';
                                    } else if (status == 'BUSY') {
                                      colorCode = '0xFFF60003';
                                    } else {
                                      colorCode = '0xFFF99F15';
                                    }
                                    return ChatTile(
                                      profileImage: ImagePath.editProfileImage,
                                      name: "Mr. Beast",
                                      message:
                                          "Hey Buddy you have won 50m dollars. Come and grab it bro.",
                                      messageReceivedTime: "5 min ago",
                                      numberOfUnreadMessage: "3",
                                      unreadMessageColor: controller
                                              .isActive.value
                                          ? AppColors
                                              .editProfileTextFieldLabelColor
                                          : AppColors.homeTextColor,
                                      activeStatusColor:
                                          Color(int.tryParse(colorCode)!),
                                      onTap: () {
                                        Get.toNamed(Routes.SINGLE_CHAT);
                                      },
                                    );
                                  }),
                            ),
                      controller.loadingController.isLoading
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {},
                              child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  String colorCode = '';
                                  String status = 'AWAY';
                                  if (status == 'ACTIVE') {
                                    colorCode = '0xFF12AE01';
                                  } else if (status == 'INACTIVE') {
                                    colorCode = '0xFFE1E2EC';
                                  } else if (status == 'AWAY') {
                                    colorCode = '0xFFF99F15';
                                  } else {
                                    colorCode = '0xFFF60003';
                                  }
                                  return ChatTile(
                                    profileImage: ImagePath.editProfileImage,
                                    name: "Group Chat",
                                    message:
                                        "Hey Buddy you have won 50m dollars. Come and grab it bro.",
                                    messageReceivedTime: "5 min ago",
                                    numberOfUnreadMessage: "3",
                                    unreadMessageColor:
                                        controller.isActive.value
                                            ? AppColors
                                                .editProfileTextFieldLabelColor
                                            : AppColors.homeTextColor,
                                    activeStatusColor:
                                        Color(int.tryParse(colorCode)!),
                                    onTap: () {
                                    },
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          backgroundColor: AppColors.primaryColor,
          onPressed: () {},
          mini: true,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
