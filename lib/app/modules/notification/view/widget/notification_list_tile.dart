import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/notification/notification_model.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_text_style.dart';


class NotificationListTile extends StatelessWidget {
  final String message;
  final String notificationDate;
  final String? userPhoto;
  const NotificationListTile({super.key, required this.message, required this.notificationDate, this.userPhoto,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: userPhoto != null && userPhoto!.isNotEmpty
                        ? NetworkImage('${AppConfig.imageBaseUrl}$userPhoto' ?? '')
                        : Image.asset(ImagePath.parentsProfile).image,
                  ),
                ),
              ),

              20.horizontalSpacing,

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: AppTextStyle.blackFontSize14W400,

                    ),
                    7.verticalSpacing,
                    Text(
                      notificationDate,
                      style: AppTextStyle.notificationText,
                    ),
                  ],
                ),
              ),
            ],
          ),

          10.verticalSpacing,

          CustomDivider(
            width: Get.width,
            color: AppColors.profileDividerColor,
          )
        ],
      ),
    );
      
      
  }
}
