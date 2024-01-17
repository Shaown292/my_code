import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/files_popup_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/popup_action_menu.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/quote_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../service/image/image_picker_utils.dart';
import '../controllers/single_chat_controller.dart';

class SingleChatView extends GetView<SingleChatController> {
  const SingleChatView({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.horizontalSpacing,
                  InkWell(
                      onTap: () {
                        Get.back();
                        controller.chatController.singleChatList.clear();
                        controller.chatController.getSingleChatList();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  15.horizontalSpacing,
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(controller.isSearchPage.value
                                  ? controller.searchChatData!.image!
                                  : controller.singleChatUserListData!.image!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 3,
                        top: 6,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isSearchPage.value ? Color(int.parse(
                                controller.searchChatData!.statusColor!),) : Color(int.parse(
                                controller.singleChatUserListData!.statusColor!),),
                          ),
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
                        controller.isSearchPage.value
                            ? controller.searchChatData!.fullName!
                            : controller.singleChatUserListData!.fullName ?? "",
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                      3.verticalSpacing,
                       Text(
                         controller.isSearchPage.value ? controller.searchChatData!.activeStatus.toString() : controller.singleChatUserListData!.activeStatus!,
                        style:  TextStyle(
                          color: controller.isSearchPage.value ? Color(int.parse(
                              controller.searchChatData!.statusColor!),) : Color(int.parse(
                              controller.singleChatUserListData!.statusColor!),),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                iconColor: Colors.white,
                onSelected: (v) {
                  if (v == 1) {
                    controller.getSingleChatFileList(
                        userId: controller.isSearchPage.value
                            ? controller.searchChatData!.userId!
                            : controller.singleChatUserListData!.id!);
                    Get.dialog(Material(
                      child: Obx(
                        () => FilesPopupDialog(
                          tabBarLength: controller.filesList.length,
                          tabController: controller.tabController,
                          tabs: List.generate(
                            controller.filesList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                      controller.singleChatImageList.length,
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
                                                      .singleChatImageList[
                                                          index]
                                                      .file ??
                                                  ""),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          fileWidget: ListView.builder(
                              itemCount: controller.singleChatFilesList.length,
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
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: AppColors
                                                .transportDividerColor
                                                .withOpacity(0.8),
                                          ),
                                          child: Image.asset(
                                            ImagePath.adminFees,
                                            scale: 4,
                                            color: Colors.black,
                                          ),
                                        ),
                                        30.horizontalSpacing,
                                        const Text(
                                          "Sajsdhjashjd",
                                          style:
                                              AppTextStyle.fontSize13BlackW400,
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
                  if (v == 2) {
                    if (controller.isSearchPage.value == false) {
                      controller.blockedUsersController.blockSingleUser(
                          type: controller.singleChatUserListData!.blocked!
                              ? ""
                              : "block",
                          userId: controller.singleChatUserListData!.id!);
                    }
                    if (controller.isSearchPage.value) {
                      controller.blockedUsersController.blockSingleUser(
                          type: controller.searchChatData!.blocked!
                              ? ""
                              : "block",
                          userId: controller.searchChatData!.userId!);
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Files"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: controller.singleChatUserListData!.blocked!
                        ? const Text("Unblock User")
                        : const Text("Block User"),
                  ),
                ],
              ),
            ],
          ),
        ),
        // titleWidget:
        body: CustomBackground(
          customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.isLoading.value
                  ? const Expanded(child: SecondaryLoadingWidget())
                  : controller.singleConversationList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: controller.singleConversationList.length,
                            itemBuilder: (context, index) {
                              controller.reversedList.value = List.from(
                                controller.singleConversationList.reversed,
                              );
                              return Column(
                                crossAxisAlignment:
                                    controller.reversedList[index].sender ==
                                            true
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: controller.reversedList[index]
                                                    .sender ==
                                                true
                                            ? 60
                                            : 0,
                                        right: controller.reversedList[index]
                                                    .sender ==
                                                true
                                            ? 0
                                            : 60),
                                    child: Row(
                                      mainAxisAlignment: controller
                                                  .reversedList[index].sender ==
                                              true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //// Sender Side
                                        controller.reversedList[index].sender ==
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
                                                            .reversedList[index]
                                                            .message,
                                                        imageUrl: controller
                                                                .reversedList[
                                                                    index]
                                                                .file ??
                                                            "",
                                                        color: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .homeworkWidgetColor,
                                                        textStyle: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppTextStyle
                                                                .textStyle12WhiteW400
                                                            : AppTextStyle
                                                                .fontSize12W400ReceivedText,
                                                        radiusBottomLeft: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 20
                                                            : 0,
                                                        radiusBottomRight: controller
                                                                    .reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? 0
                                                            : 20,
                                                        onDeleteTap: () {
                                                          controller.deleteSingleChat(
                                                              messageId: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .messageId!,
                                                              index: index);
                                                        },
                                                        onForwardTap: () {
                                                          controller
                                                              .forwardChat(
                                                            messageId: controller
                                                                .reversedList[
                                                                    index]
                                                                .messageId!,
                                                            context: context,
                                                          );
                                                        },
                                                        onQuoteTap: () {
                                                          Get.back();
                                                          controller.quotedText
                                                              .value = controller
                                                                  .reversedList[
                                                                      index]
                                                                  .message ??
                                                              "";
                                                          controller.onTapQuote
                                                              .value = true;
                                                          controller.replyId
                                                                  .value =
                                                              controller
                                                                  .reversedList[
                                                                      index]
                                                                  .messageId!;
                                                        },
                                                        isReceiver: controller
                                                            .reversedList[index]
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

                                        /// Main Chat Screen
                                        Flexible(
                                          child: ChatTextTile(
                                            text: controller.reversedList[index]
                                                    .message ??
                                                "",
                                            color: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            forwardImageBackgroundColor:
                                                controller.reversedList[index]
                                                            .sender ==
                                                        true
                                                    ? AppColors.primaryColor
                                                    : AppColors
                                                        .homeworkWidgetColor,
                                            textStyle: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            forwardedTextStyle: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            radiusBottomLeft: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 20
                                                : 0,
                                            radiusBottomRight: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 20,
                                            textLeftPadding: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 0
                                                : 10,
                                            textRightPadding: controller
                                                        .reversedList[index]
                                                        .sender ==
                                                    true
                                                ? 10
                                                : 0,
                                            imageUrl: controller
                                                    .reversedList[index].file ??
                                                "",
                                            isForwardedText: controller
                                                    .reversedList[index]
                                                    .forwarded ??
                                                false,
                                            isQuotedText: controller
                                                .reversedList[index].reply!,
                                            quotedText: controller
                                                .reversedList[index].replyFor,
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
                                                                        .reversedList[
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

                                        /// Receiver side
                                        controller.reversedList[index].sender ==
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
                                                          .reversedList[index]
                                                          .message,
                                                      color: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .homeworkWidgetColor,
                                                      textStyle: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppTextStyle
                                                              .textStyle12WhiteW400
                                                          : AppTextStyle
                                                              .fontSize12W400ReceivedText,
                                                      radiusBottomLeft: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 30
                                                          : 0,
                                                      radiusBottomRight: controller
                                                                  .reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? 0
                                                          : 30,
                                                      onForwardTap: () {
                                                        controller.forwardChat(
                                                          messageId: controller
                                                              .reversedList[
                                                                  index]
                                                              .messageId!,
                                                          context: context,
                                                        );
                                                      },
                                                      onQuoteTap: () {
                                                        Get.back();
                                                        controller.quotedText
                                                            .value = controller
                                                                .reversedList[
                                                                    index]
                                                                .message ??
                                                            "";
                                                        controller.onTapQuote
                                                            .value = true;
                                                        controller
                                                                .replyId.value =
                                                            controller
                                                                .reversedList[
                                                                    index]
                                                                .messageId!;
                                                      },
                                                      isReceiver: controller
                                                          .reversedList[index]
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
                      : const Expanded(child: NoDataAvailableWidget()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: const Color(0xFFFDFBFF),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.onTapQuote.value
                              ? QuoteText(
                                  repliedText: controller.quotedText.value == ""
                                      ? "Attachment"
                                      : controller.quotedText.value,
                                )
                              : const SizedBox(),
                          controller.singleChatPickImage.value.path.isNotEmpty
                              ? Row(
                                  children: [
                                    Image.file(
                                      height: 60,
                                      width: 80,
                                      File(controller
                                          .singleChatPickImage.value.path),
                                      fit: BoxFit.cover,
                                    ),
                                    5.horizontalSpacing,
                                    InkWell(
                                      onTap: () {
                                        controller.singleChatPickImage.value =
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
                          controller.searchChatData?.blocked == true ||
                                  controller.singleChatUserListData?.blocked ==
                                      true
                              ? SizedBox(
                                  width: Get.width,
                                  child: const Center(
                                    child: Text(
                                      "You can't to reply this conversation",
                                      style:
                                          AppTextStyle.fontSize16lightBlackW500,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FlutterImagePickerUtils
                                            .imagePickerModalSheet(
                                          context: context,
                                          fromGallery: () async {
                                            controller
                                                    .singleChatPickImage.value =
                                                await FlutterImagePickerUtils
                                                    .getImageGallery(
                                              context,
                                            );
                                          },
                                          fromCamera: () async {
                                            controller
                                                    .singleChatPickImage.value =
                                                await FlutterImagePickerUtils
                                                    .getImageCamera(
                                              context,
                                            );
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        ImagePath.camera,
                                        color: AppColors
                                            .editProfileTextFieldLabelColor,
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
                                        hintTextStyle:
                                            AppTextStyle.homeworkElements,
                                        hintText: "Type something...",
                                        controller:
                                            controller.sendTextController,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (controller.validation()) {
                                          controller.singleChatSend();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
