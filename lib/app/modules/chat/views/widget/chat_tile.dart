import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ChatTile extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final String? message;
  final String? messageReceivedTime;
  final String? numberOfUnreadMessage;
  final Color? unreadMessageColor;
  final Function()? onTap;
  final Function()? onTapUnblock;
  final Color? activeStatusColor;
  final bool isBlocked;

  const ChatTile({
    super.key,
    this.profileImageUrl,
    this.name,
    this.message,
    this.messageReceivedTime,
    this.numberOfUnreadMessage,
    this.unreadMessageColor,
    this.onTap, this.activeStatusColor, this.isBlocked = false, this.onTapUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    profileImageUrl == '' ?
                    Container(
                      height: Get.height * 0.1,
                      width: Get.width * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(ImagePath.dp),
                            fit: BoxFit.cover),
                      ),
                    ) :
                    SizedBox(
                      height: Get.height * 0.1,
                      width: Get.width * 0.15,
                      child: ClipRRect(
                        borderRadius:
                        6.circularRadius,
                        child: CacheImageView(
                          url: profileImageUrl,
                          errorImageLocal:
                          ImagePath.errorImage,
                        ),
                      ),
                    ),
                    Positioned(
                      right: Get.width * 0.015,
                      top: Get.height * 0.02,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeStatusColor),
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
                      name ?? "",
                      style: AppTextStyle.blackFontSize14W400,
                    ),
                    5.verticalSpacing,
                    SizedBox(
                      width: Get.width * 0.48,
                      child: Text(
                        message ?? "",
                        style: TextStyle(
                            color: unreadMessageColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                isBlocked ? InkWell(
                  onTap: onTapUnblock,
                  child: Container(
                   padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.activeStatusGreenColor,
                    ),
                    child: const Text(
                      "Unblock", style: AppTextStyle.cardTextStyle14WhiteW500,),

                  ),
                ) : Text(
                  messageReceivedTime ?? "",
                  style: AppTextStyle.homeworkElements,
                ),
              ],
            ),

            10.verticalSpacing,
            CustomDivider(
              width: Get.width,
              color: AppColors.transportDividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
