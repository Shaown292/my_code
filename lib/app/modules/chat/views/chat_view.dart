import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat/views/widget/chat_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
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
          Obx(() {
            return SizedBox(
              width: 150,
              child: DuplicateDropdown(
                padding: EdgeInsets.zero,
                dropdownValue: controller.activeStatus.value,
                dropdownList: controller.activeStatusList,
                color: Colors.white,
                dropdownText: false,
                changeDropdownValue: (v) {
                  controller.activeStatus.value = v!;
                  controller.key.value = v.key;
                  controller.changeStatus(statusKey: controller.key.value);
                },
                dropdownColor: AppColors.activeExamStatusBlueColor,
              ),
            );
          }),
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
                onTap: (index) {
                  controller.tabIndex.value = index;
                },
              ),
              10.verticalSpacing,
              Obx(
                () => Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Single Chat List
                      controller.singleChatListLoader.value
                          ? const SecondaryLoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {
                                controller.singleChatList.clear();
                                controller.getSingleChatList();
                              },
                              child: controller.singleChatList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.singleChatList.length,
                                      itemBuilder: (context, index) {
                                        return ChatTile(
                                          profileImageUrl: controller
                                              .singleChatList[index].image,
                                          name: controller
                                              .singleChatList[index].fullName,
                                          message: controller
                                              .singleChatList[index]
                                              .lastMessage,
                                          messageReceivedTime:
                                              controller.formatTimeAgo(
                                            DateTime.parse(controller
                                                    .singleChatList[index]
                                                    .lastMessageTime ??
                                                ''),
                                          ),
                                          numberOfUnreadMessage: controller
                                              .singleChatList[index]
                                              .countConversation
                                              .toString(),
                                          unreadMessageColor: controller.isActive
                                                  .value
                                              ? AppColors
                                                  .editProfileTextFieldLabelColor
                                              : AppColors.homeTextColor,
                                          onTap: () {
                                            Get.toNamed(Routes.SINGLE_CHAT,
                                                arguments: {
                                                  'single_chat_list': controller
                                                      .singleChatList[index]
                                                });
                                          },
                                          activeStatusColor: Color(
                                            int.parse(
                                              controller.singleChatList[index]
                                                  .statusColor!,
                                            ),
                                          ),
                                        );
                                      })
                                  : const Center(
                                      child: NoDataAvailableWidget()),
                            ),

                      /// Group Chat List
                      controller.groupChatListLoader.value
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {
                                controller.groupChatList.clear();
                                controller.getGroupChatList();
                              },
                              child: controller.groupChatList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          controller.groupChatList.length,
                                      itemBuilder: (context, index) {
                                        return ChatTile(
                                          profileImageUrl: controller
                                                  .groupChatList[index].image ??
                                              "",
                                          name: controller
                                              .groupChatList[index].name,
                                          message: controller
                                              .groupChatList[index].lastMessage,
                                          messageReceivedTime:
                                              controller.formatTimeAgo(
                                            DateTime.parse(controller
                                                    .groupChatList[index]
                                                    .lastMessageTime ??
                                                ''),
                                          ),
                                          numberOfUnreadMessage: controller
                                              .groupChatList[index]
                                              .countConversation
                                              .toString(),
                                          unreadMessageColor: controller.isActive
                                                  .value
                                              ? AppColors
                                                  .editProfileTextFieldLabelColor
                                              : AppColors.homeTextColor,
                                          onTap: () {
                                            Get.toNamed(Routes.GROUP_CHAT,
                                                arguments: {
                                                  'group_id': controller
                                                      .groupChatList[index]
                                                      .groupId,
                                                  'name': controller
                                                      .groupChatList[index]
                                                      .name,
                                                  'image': controller
                                                      .groupChatList[index]
                                                      .image,
                                                });
                                          },
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: NoDataAvailableWidget(),
                                    ),
                            ),
                    ],
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
