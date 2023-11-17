import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/image_view/cache_image_view.dart';


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

              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: 100.circularRadius,
                  child: CacheImageView(
                    url: '${AppConfig.imageBaseUrl}$userPhoto',
                    errorImageLocal: 'assets/image/production/avatar.png',
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
