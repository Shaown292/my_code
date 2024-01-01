import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/files_popup_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/popup_action_menu.dart';
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
                      ////////// NEEEEEED TOOOO CHEEEECCKKKKKKK
                      Get.back();
                      controller.chatController.singleChatList.clear();
                      controller.chatController.getSingleChatList();
                      // controller.chatController.singleChatList.refresh();
                    },
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
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      controller.userImage.isEmpty
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(ImagePath.dp),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        controller.userImage.value),
                                    fit: BoxFit.cover),
                              ),
                            ),
                      Positioned(
                        right: 3,
                        top: 6,
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
                        controller.userName.value,
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
              PopupMenuButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                iconColor: Colors.white,
                onSelected: (v) {
                  if (v == 1) {
                    controller.getSingleChatFileList(userId: controller.toUserId.value);
                    controller.filePopup(
                      widget: FilesPopupDialog(
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
                        numberOfImage: controller.singleChatFileList.length,
                        onTap: (index) {
                          controller.tabIndex.value = index;
                        },
                      ),
                    );
                  }
                  if (v == 2) {
                    controller.blockSingleUser(
                        type: controller.isBlocked.value ? "" : "block",
                        userId: controller.toUserId.value);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Files"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: controller.isBlocked.value
                        ? const Text("Unblock User")
                        : const Text("Block User"),
                  ),
                ],
              )
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
                              var reversedList = List.from(
                                  controller.singleConversationList.reversed);
                              return Column(
                                crossAxisAlignment:
                                    reversedList[index].sender == true
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: reversedList[index].sender == true
                                            ? 60
                                            : 0,
                                        right:
                                            reversedList[index].sender == true
                                                ? 0
                                                : 60),
                                    child: Row(
                                      mainAxisAlignment:
                                          reversedList[index].sender == true
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        reversedList[index].sender == true
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
                                                        text:
                                                            reversedList[index]
                                                                .message,
                                                        imageUrl:
                                                            reversedList[index]
                                                                    .file ??
                                                                "",
                                                        color: reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .homeworkWidgetColor,
                                                        textStyle: reversedList[
                                                                        index]
                                                                    .sender ==
                                                                true
                                                            ? AppTextStyle
                                                                .textStyle12WhiteW400
                                                            : AppTextStyle
                                                                .fontSize12W400ReceivedText,
                                                        radiusBottomLeft:
                                                            reversedList[index]
                                                                        .sender ==
                                                                    true
                                                                ? 20
                                                                : 0,
                                                        radiusBottomRight:
                                                            reversedList[index]
                                                                        .sender ==
                                                                    true
                                                                ? 0
                                                                : 20,
                                                        onDeleteTap: () {
                                                          controller.deleteSingleChat(
                                                              messageId:
                                                                  reversedList[
                                                                          index]
                                                                      .messageId!,
                                                              index: index);
                                                        },
                                                        onForwardTap: () {
                                                          controller
                                                              .forwardChat(
                                                            messageId:
                                                                reversedList[
                                                                        index]
                                                                    .messageId!,
                                                            context: context,
                                                          );
                                                        },
                                                        onQuoteTap: () {
                                                          debugPrint(
                                                              "Tapped on quote");
                                                        },
                                                        isReceiver:
                                                            reversedList[index]
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
                                            text: reversedList[index].message ??
                                                "",
                                            color: reversedList[index].sender ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.homeworkWidgetColor,
                                            forwardImageBackgroundColor:
                                                reversedList[index].sender ==
                                                        true
                                                    ? AppColors.primaryColor
                                                    : AppColors
                                                        .homeworkWidgetColor,
                                            textStyle: reversedList[index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            forwardedTextStyle: reversedList[
                                                            index]
                                                        .sender ==
                                                    true
                                                ? AppTextStyle
                                                    .textStyle12WhiteW400
                                                : AppTextStyle
                                                    .fontSize12W400ReceivedText,
                                            radiusBottomLeft:
                                                reversedList[index].sender ==
                                                        true
                                                    ? 20
                                                    : 0,
                                            radiusBottomRight:
                                                reversedList[index].sender ==
                                                        true
                                                    ? 0
                                                    : 20,
                                            textLeftPadding:
                                                reversedList[index].sender ==
                                                        true
                                                    ? 0
                                                    : 10,
                                            textRightPadding:
                                                reversedList[index].sender ==
                                                        true
                                                    ? 10
                                                    : 0,
                                            imageUrl:
                                                reversedList[index].file ?? "",
                                            isForwardedText:
                                                reversedList[index].forwarded ??
                                                    false,
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
                                                                reversedList[
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
                                        reversedList[index].sender == false
                                            ? InkWell(
                                                onTap: () {
                                                  Get.dialog(Material(
                                                    color: Colors.transparent,
                                                    child: PopupActionMenu(
                                                      positionLeft: 20,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      text: reversedList[index]
                                                          .message,
                                                      color: reversedList[index]
                                                                  .sender ==
                                                              true
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors
                                                              .homeworkWidgetColor,
                                                      textStyle: reversedList[
                                                                      index]
                                                                  .sender ==
                                                              true
                                                          ? AppTextStyle
                                                              .textStyle12WhiteW400
                                                          : AppTextStyle
                                                              .fontSize12W400ReceivedText,
                                                      radiusBottomLeft:
                                                          reversedList[index]
                                                                      .sender ==
                                                                  true
                                                              ? 30
                                                              : 0,
                                                      radiusBottomRight:
                                                          reversedList[index]
                                                                      .sender ==
                                                                  true
                                                              ? 0
                                                              : 30,
                                                      onForwardTap: () {
                                                        print(
                                                            "text:::: ${reversedList[index].message}");
                                                        print(
                                                            "msg id:::: ${reversedList[index].messageId}");
                                                        controller.forwardChat(
                                                          messageId:
                                                              reversedList[
                                                                      index]
                                                                  .messageId!,
                                                          context: context,
                                                        );
                                                      },
                                                      onQuoteTap: () {
                                                        debugPrint(
                                                            "Tapped on quote");
                                                      },
                                                      isReceiver:
                                                          reversedList[index]
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        controller.isBlocked.value
                            ? SizedBox(
                                width: Get.width,
                                child: const Center(
                                  child: Text(
                                    "You can't to reply this conversetion",
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
                                          controller.singleChatPickImage.value =
                                              await FlutterImagePickerUtils
                                                  .getImageGallery(
                                            context,
                                          );
                                        },
                                        fromCamera: () async {
                                          controller.singleChatPickImage.value =
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
                                      controller: controller.sendTextController,
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
            ],
          ),
        ),
      ),
    );
  }
}
