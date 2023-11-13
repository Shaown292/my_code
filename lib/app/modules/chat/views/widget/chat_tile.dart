import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ChatTile extends StatelessWidget {
  final String? profileImage;
  final String? name;
  final String? message;
  final String? messageReceivedTime;
  final String? numberOfUnreadMessage;
  final Color? unreadMessageColor;
  final Function()? onTap;
  final Color? activeStatusColor;

  const ChatTile({
    super.key,
    this.profileImage,
    this.name,
    this.message,
    this.messageReceivedTime,
    this.numberOfUnreadMessage,
    this.unreadMessageColor,
    this.onTap, this.activeStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Row(
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
                            image: AssetImage(profileImage ?? ""),
                            fit: BoxFit.cover),
                      ),
                    ),
                   Positioned(
                      right: 0,
                      top: 10,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeStatusColor ),
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
                      width: Get.width * 0.5,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      messageReceivedTime ?? "",
                      style: AppTextStyle.homeworkElements,
                    ),
                    5.verticalSpacing,
                    Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.unreadChat),
                      child: Center(
                        child: Text(
                          numberOfUnreadMessage ?? "",
                          style: AppTextStyle.textStyle12WhiteW400,
                        ),
                      ),
                    )
                  ],
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
