import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/single_chat/views/widget/popup_action_menu.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
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
                          const Text(
                            "Patrcik Nelson",
                            style: AppTextStyle.cardTextStyle14WhiteW500,
                          ),
                          3.verticalSpacing,
                          const Text(
                            "Online now",
                            style: AppTextStyle.fontSize10GreenW700,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // titleWidget:
        body: CustomBackground(
          customWidget: Column(
            children: [
              Obx(() => controller.isLoading.value ? const CircularProgressIndicator() : controller.singleConversationList.isNotEmpty ? Expanded(
                child: ListView.builder(
                  // reverse: true,
                  shrinkWrap: true,
                  itemCount: controller.singleConversationList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: controller.singleConversationList[index].sender!
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: controller.singleConversationList[index].sender! ? 60 : 0, right: controller.singleConversationList[index].sender! ? 0 : 60),
                          child: Row(
                            mainAxisAlignment: controller.singleConversationList[index].sender!
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              controller.singleConversationList[index].sender!
                                  ? InkWell(
                                onTap: () {
                                  Get.dialog(
                                    Material(
                                      color: Colors.transparent,
                                      child: PopupActionMenu(
                                        positionRight: 20,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        text: controller.singleConversationList[index].message,
                                        color: controller.singleConversationList[index].sender!
                                            ? AppColors.primaryColor
                                            : AppColors.homeworkWidgetColor,
                                        textStyle: controller.singleConversationList[index].sender!
                                            ? AppTextStyle
                                            .textStyle12WhiteW400
                                            : AppTextStyle
                                            .fontSize12W400ReceivedText,
                                        radiusBottomLeft:
                                        controller.singleConversationList[index].sender! ? 20 : 0,
                                        radiusBottomRight:
                                        controller.singleConversationList[index].sender! ? 0 : 20,
                                        onDeleteTap: () {
                                          debugPrint("Tapped on delete");
                                        },
                                        onForwardTap: () {
                                          debugPrint("Tapped on forward");
                                        },
                                        onQuoteTap: () {
                                          debugPrint("Tapped on quote");
                                        },
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
                                  text: controller.singleConversationList[index].message,
                                  imageUrl: controller.singleConversationList[index].file,
                                  color: controller.singleConversationList[index].sender!
                                      ? AppColors.primaryColor
                                      : AppColors.homeworkWidgetColor,
                                  textStyle: controller.singleConversationList[index].sender!
                                      ? AppTextStyle.textStyle12WhiteW400
                                      : AppTextStyle.fontSize12W400ReceivedText,
                                  radiusBottomLeft: controller.singleConversationList[index].sender! ? 20 : 0,
                                  radiusBottomRight: controller.singleConversationList[index].sender! ? 0 : 20,
                                  textLeftPadding: controller.singleConversationList[index].sender! ? 0 : 10,
                                  textRightPadding: controller.singleConversationList[index].sender! ? 10 : 0,
                                ),
                              ),
                              controller.singleConversationList[index].sender!
                                  ? InkWell(
                                onTap: () {
                                  Get.dialog(
                                      Material(
                                        color: Colors.transparent,
                                        child: PopupActionMenu(
                                          positionLeft: 20,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          text: controller.singleConversationList[index].message,
                                          color: controller.singleConversationList[index].sender!
                                              ? AppColors.primaryColor
                                              : AppColors.homeworkWidgetColor,
                                          textStyle: controller.singleConversationList[index].sender!
                                              ? AppTextStyle
                                              .textStyle12WhiteW400
                                              : AppTextStyle
                                              .fontSize12W400ReceivedText,
                                          radiusBottomLeft:
                                          controller.singleConversationList[index].sender! ? 30 : 0,
                                          radiusBottomRight:
                                          controller.singleConversationList[index].sender! ? 0 : 30,
                                          onDeleteTap: () {
                                            Get.back();
                                            debugPrint("Tapped on delete");
                                          },
                                          onForwardTap: () {
                                            debugPrint("Tapped on forward");
                                          },
                                          onQuoteTap: () {
                                            debugPrint("Tapped on quote");
                                          },
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
              ) : const Expanded(child: NoDataAvailableWidget()),),
              Container(
                padding: const EdgeInsets.all(15),
                color: const Color(0xFFFDFBFF),
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
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            FlutterImagePickerUtils.imagePickerModalSheet(
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
                            if(controller.validation()){
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
            ],
          ),
        ),
      ),
    );
  }
}
