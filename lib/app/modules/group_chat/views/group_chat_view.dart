import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat_search/views/widget/suggested_search_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/group_chat/views/widget/group_chat_helper.dart';
import 'package:flutter_single_getx_api_v2/app/modules/group_chat/views/widget/selecting_member.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/files_popup_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/popup_action_menu.dart';
import 'package:flutter_single_getx_api_v2/app/service/image/image_picker_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../controllers/group_chat_controller.dart';

class GroupChatView extends GetView<GroupChatController> {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        appBarHeight: 120,
        appBar: Padding(
          padding:
              const EdgeInsets.only(top: 80.0, bottom: 20, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.horizontalSpacing,
                  InkWell(
                    onTap: Get.back,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagePath.back),
                            filterQuality: FilterQuality.high),
                      ),
                    ),
                  ),
                  15.horizontalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(ImagePath.dp),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            right: Get.width * 0.005,
                            top: Get.height * 0.01,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                            ), //Icon
                          ),
                        ], //<Widget>[]
                      ),
                      10.horizontalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.chatName.value,
                            style: AppTextStyle.cardTextStyle14WhiteW500,
                          ),
                          3.verticalSpacing,
                          const Text(
                            "Online now",
                            style: AppTextStyle.fontSize10GreenW700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GroupChatHelper().popupMenu(onTap: (v) {
                /// Add People
                if (v == 1) {
                  Get.dialog(Material(
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectingMember(
                              searchTextController:
                                  controller.searchTextController,
                              onChange: (searchKey) {
                                controller
                                    .chatSearchController.searchChatDataList
                                    .clear();
                                controller.chatSearchController
                                    .getSearchChat(searchKey);
                              },
                              onAddButtonTap: controller.userList.isEmpty
                                  ? null
                                  : () {
                                      controller.groupAddMember(
                                          groupId: controller.groupId.value,
                                          userList: controller.userList);
                                      controller.clearCheckboxData();
                                      controller.searchTextController.clear();
                                    },
                              textStyle: controller.userList.isEmpty
                                  ? AppTextStyle.fontSize13GreyW300
                                  : AppTextStyle.blackFontSize14W400,
                              backOnTap: () {
                                controller.clearCheckboxData();
                                controller.searchTextController.clear();
                                Get.back();
                              },
                            ),
                            20.verticalSpacing,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: controller.chatSearchController
                                          .searchLoader.value ||
                                      controller.addMemberLoader.value
                                  ? const SecondaryLoadingWidget()
                                  : controller
                                          .searchTextController.text.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .chatSearchController
                                              .searchChatDataList
                                              .length,
                                          itemBuilder: (context, index) {
                                            return SuggestedSearchTile(
                                              profileImage:
                                                  ImagePath.editProfileImage,
                                              name: controller
                                                  .chatSearchController
                                                  .searchChatDataList[index]
                                                  .fullName,
                                              onTap: () {},
                                              checkboxValue: controller
                                                  .chatSearchController
                                                  .searchChatDataList[index]
                                                  .isSelected,
                                              onCheckboxTap: (bool? value) {
                                                controller
                                                        .chatSearchController
                                                        .searchChatDataList[index]
                                                        .isSelected =
                                                    !controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected;
                                                controller.chatSearchController
                                                    .searchChatDataList
                                                    .refresh();
                                                if (controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected ==
                                                    true) {
                                                  controller.userList.add(
                                                      controller
                                                          .chatSearchController
                                                          .searchChatDataList[
                                                              index]
                                                          .userId
                                                          .toString());
                                                }

                                                if (controller
                                                        .chatSearchController
                                                        .searchChatDataList[
                                                            index]
                                                        .isSelected ==
                                                    false) {
                                                  controller.userList.remove(
                                                      controller
                                                          .chatSearchController
                                                          .searchChatDataList[
                                                              index]
                                                          .userId
                                                          .toString());
                                                }
                                              },
                                            );
                                          })
                                      : const Center(
                                          child: NoDataAvailableWidget(),
                                        ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }

                /// File

                else if (v == 2) {
                  controller.getGroupChatFileList(
                    groupId: controller.groupId.value,
                  );
                  Get.dialog(Material(
                    child: Obx(
                      () => FilesPopupDialog(
                        tabBarLength: controller.filesList.length,
                        tabController: controller.tabController,
                        tabs: List.generate(
                          controller.filesList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              controller.filesList[index],
                            ),
                          ),
                        ),
                        imageWidget: controller.fileLoader.value
                            ? const SecondaryLoadingWidget()
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.groupChatImageList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                    .groupChatImageList[index]
                                                    .file ??
                                                ""),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        fileWidget: ListView.builder(
                            itemCount: controller.groupChatFilesList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Container(
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.transportDividerColor
                                        .withOpacity(0.4),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Get.width * 0.15,
                                        height: Get.height * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: AppColors.transportDividerColor
                                              .withOpacity(0.8),
                                        ),
                                        child: Image.asset(
                                          ImagePath.adminFees,
                                          scale: 4,
                                          color: Colors.black,
                                        ),
                                      ),
                                      30.horizontalSpacing,
                                       Text(
                                        controller.groupChatFilesList[index].originalFileName!,
                                        style: AppTextStyle.fontSize13BlackW400,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        onTap: (index) {
                          controller.tabIndex.value = index;
                        },
                      ),
                    ),
                  ));
                }

                /// Member List
                else if (v == 3) {
                  controller.getGroupChatMemberList(
                      groupId: controller.groupId.value);
                  GroupChatHelper().showGroupMemberListBottomSheet(
                    header: "Members",
                    bottomSheetBackgroundColor: Colors.white,
                  );
                }

                /// Delete Group

                else if (v == 4) {
                  controller.groupDelete(groupId: controller.groupId.value);
                }

                /// Group Leave
                else if (v == 5) {
                  controller.groupLeaveMember(
                      groupId: controller.groupId.value);
                }
              })
            ],
          ),
        ),
        // titleWidget:
        body: CustomBackground(
          customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.groupChatDataLoader.value
                  ? const Expanded(child: SecondaryLoadingWidget())
                  : controller.groupChatConversationList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount:
                                controller.groupChatConversationList.length,
                            itemBuilder: (context, index) {
                              controller.reversedConversationList.value =
                                  List.from(controller
                                      .groupChatConversationList.reversed);
                              return Column(
                                crossAxisAlignment: controller
                                            .reversedConversationList[index]
                                            .sender ==
                                        true
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? 60
                                            : 0,
                                        right: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? 0
                                            : 60),
                                    child: Row(
                                      mainAxisAlignment: controller
                                                  .reversedConversationList[
                                                      index]
                                                  .sender ==
                                              true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                true
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: PopupActionMenu(
                                                        positionRight: 20,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        text: controller
                                                            .reversedConversationList[
                                                                index]
                                                            .message,
                                                        imageUrl: controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .file ??
                                                            "",
                                                        color: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .homeworkWidgetColor,
                                                        textStyle: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppTextStyle
                                                                .textStyle12WhiteW400
                                                            : AppTextStyle
                                                                .fontSize12W400ReceivedText,
                                                        radiusBottomLeft: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 20
                                                            : 0,
                                                        radiusBottomRight: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 0
                                                            : 20,
                                                        onDeleteTap: () {
                                                          controller.deleteSingleChat(
                                                              threadId: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .threadId!,
                                                              index: index);
                                                        },
                                                        onForwardTap: () {
                                                          controller.forwardChat(
                                                              context: context,
                                                              messageId: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .messageId!,
                                                              message: controller
                                                                      .reversedConversationList[
                                                                          index]
                                                                      .message ??
                                                                  "");
                                                        },
                                                        onQuoteTap: () {
                                                          debugPrint(
                                                              "Tapped on quote");
                                                        },
                                                        isReceiver: controller
                                                            .reversedConversationList[
                                                                index]
                                                            .receiver!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.more_vert,
                                                  size: 16,
                                                ),
                                              )
                                            : const SizedBox(),
                                        Flexible(
                                          child: ChatTextTile(
                                            text: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .message ??
                                                "",
                                            color: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            forwardImageBackgroundColor: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            textStyle: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            forwardedTextStyle: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            radiusBottomLeft: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 20
                                                : 0,
                                            radiusBottomRight: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 20,
                                            textLeftPadding: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 10,
                                            textRightPadding: controller
                                                        .reversedConversationList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? 10
                                                : 0,
                                            imageUrl: controller
                                                    .reversedConversationList[
                                                        index]
                                                    .file ??
                                                "",
                                            // isForwardedText: controller
                                            //     .reversedConversationList[index]
                                            //     .forwarded ??
                                            //     false,
                                            onImageTap: () {
                                              Get.dialog(
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () => Get.back(),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child:
                                                                Positioned.fill(
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 10,
                                                                  sigmaY: 10,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height:
                                                              Get.height * 0.7,
                                                          width:
                                                              Get.width * 0.7,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                controller
                                                                        .reversedConversationList[
                                                                            index]
                                                                        .file ??
                                                                    "",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        controller
                                                    .reversedConversationList[
                                                        index]
                                                    .sender ==
                                                false
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(Material(
                                                    color: Colors.transparent,
                                                    child: PopupActionMenu(
                                                      positionLeft: 20,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      text: controller
                                                          .reversedConversationList[
                                                              index]
                                                          .message,
                                                      color: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .homeworkWidgetColor,
                                                      textStyle: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppTextStyle
                                                              .textStyle12WhiteW400
                                                          : AppTextStyle
                                                              .fontSize12W400ReceivedText,
                                                      radiusBottomLeft: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 30
                                                          : 0,
                                                      radiusBottomRight: controller
                                                                  .reversedConversationList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 0
                                                          : 30,
                                                      onForwardTap: () {
                                                        controller.forwardChat(
                                                            context: context,
                                                            messageId: controller
                                                                .reversedConversationList[
                                                                    index]
                                                                .messageId!,
                                                            message: controller
                                                                    .reversedConversationList[
                                                                        index]
                                                                    .message ??
                                                                "");
                                                      },
                                                      onQuoteTap: () {
                                                        debugPrint(
                                                            "Tapped on quote");
                                                      },
                                                      isReceiver: controller
                                                          .reversedConversationList[
                                                              index]
                                                          .receiver!,
                                                    ),
                                                  ));
                                                },
                                                child: const Icon(
                                                  Icons.more_vert,
                                                  size: 16,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : const Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            children: [
                              NoDataAvailableWidget(
                                message: "No message available",
                              ),
                            ],
                          ),
                        )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: const Color(0xFFFDFBFF),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.groupChatPickImage.value.path.isNotEmpty
                            ? Row(
                                children: [
                                  Image.file(
                                    height: 60,
                                    width: 80,
                                    File(controller
                                        .groupChatPickImage.value.path),
                                    fit: BoxFit.cover,
                                  ),
                                  5.horizontalSpacing,
                                  InkWell(
                                    onTap: () {
                                      controller.groupChatPickImage.value =
                                          File('');
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        10.verticalSpacing,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                FlutterImagePickerUtils.imagePickerModalSheet(
                                  context: context,
                                  fromGallery: () async {
                                    controller.groupChatPickImage.value =
                                        await FlutterImagePickerUtils
                                            .getImageGallery(
                                      context,
                                    );
                                  },
                                  fromCamera: () async {
                                    controller.groupChatPickImage.value =
                                        await FlutterImagePickerUtils
                                            .getImageCamera(
                                      context,
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                ImagePath.camera,
                                color: AppColors.editProfileTextFieldLabelColor,
                              ),
                            ),
                            10.horizontalSpacing,
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: AppColors.dividerColor,
                              ),
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                inputBorder: InputBorder.none,
                                hintTextStyle: AppTextStyle.homeworkElements,
                                hintText: "Type something...",
                                controller: controller.sendTextController,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.validation()) {
                                  controller.groupChatSend();
                                }
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        color: AppColors.primaryColor),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ImagePath.send,
                                    scale: 2.5,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
