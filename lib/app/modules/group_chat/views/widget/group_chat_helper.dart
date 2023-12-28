import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/group_chat/controllers/group_chat_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class GroupChatHelper {

  GroupChatController groupChatController = Get.find();

  PopupMenuButton<int> popupMenu({required Function(int) onTap}) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconColor: Colors.white,
      onSelected: onTap,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("User Role"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Add People"),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text("Members"),
        ),
        const PopupMenuItem(
          value: 4,
          child: Text("File"),
        ),
        const PopupMenuItem(
          value: 5,
          child: Text("Leave Group"),
        ),
        const PopupMenuItem(
          value: 6,
          child: Text("Delete Group"),
        ),
        const PopupMenuItem(
          value: 7,
          child: Text("Mark as Read only"),
        ),
      ],
    );
  }

  void showUploadDocumentsBottomSheet({
    Color? bottomSheetBackgroundColor,
    String? header,
    Function()? onDeleteTap,

  }) {
    Get.bottomSheet(
      Container(
        height: Get.height ,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: bottomSheetBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      header ?? "",
                      style: AppTextStyle.cardTextStyle14WhiteW500,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: Get.height * 0.4,
                child: ListView.builder(
                    itemCount: groupChatController.groupChatMemberList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                            child: Row(
                              children: [
                                groupChatController.groupChatMemberList[index].image == ""
                                    ? Container(
                                        height: Get.height * 0.07,
                                        width: Get.width * 0.13,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(ImagePath.dp),
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      )
                                    : SizedBox(
                                        height: Get.height * 0.055,
                                        width: Get.width * 0.11,
                                        child: ClipRRect(
                                          borderRadius: 6.circularRadius,
                                          child: CacheImageView(
                                            url: groupChatController.groupChatMemberList[index].image,
                                            errorImageLocal: ImagePath.errorImage,
                                          ),
                                        ),
                                      ),
                                20.horizontalSpacing,
                                 Text(groupChatController.groupChatMemberList[index].fullName ?? "",
                                  style: AppTextStyle.fontSize13BlackW400,
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: (){
                                    groupChatController.removeSingleMemberFromGroup(groupId: groupChatController.groupId.value, userId: groupChatController.groupChatMemberList[index].userId!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      ImagePath.delete,
                                      scale: 4.5,
                                      color: AppColors.activeStatusRedColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const CustomDivider(
                            color: AppColors.customDividerColor,
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }
}
