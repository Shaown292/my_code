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
                padding: 0,
                dropdownValue: controller.dropdownValue.value,
                dropdownList: controller.activeStatusList,
                color: Colors.white,
                dropdownText: false,
                changeDropdownValue: (v) {
                  controller.dropdownValue.value = v!;
                },
                // activeStatusColor:  Color(int.parse(controller.changeActiveStatusColor()!)),
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
            onSelected: (value) {
              if (value == 1) {}
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
                      controller.singleChatListLoader.value
                          ? const SecondaryLoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {},
                              child: controller.singleChatList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.singleChatList.length,
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
                                          activeStatusColor:
                                              Color(int.tryParse(colorCode)!),
                                          onTap: () {

                                            Get.toNamed(Routes.SINGLE_CHAT, arguments: {'to_user_id': controller.singleChatList[index].id});
                                          },
                                        );
                                      })
                                  : const Center(
                                      child: NoDataAvailableWidget()),
                            ),
                      controller.groupChatListLoader.value
                          ? const LoadingWidget()
                          : RefreshIndicator(
                              color: AppColors.primaryColor,
                              onRefresh: () async {},
                              child: controller.groupChatList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          controller.groupChatList.length,
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
                                          activeStatusColor:
                                              Color(int.tryParse(colorCode)!),
                                          onTap: () {
                                            Get.toNamed(Routes.SINGLE_CHAT);
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
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          backgroundColor: AppColors.primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
