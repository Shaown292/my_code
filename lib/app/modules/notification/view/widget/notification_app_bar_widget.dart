import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notification/controllers/notification_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/image_path.dart';

class NotificationAppBarWidget extends StatelessWidget {
  final int? notificationCount;
   const NotificationAppBarWidget({super.key, this.notificationCount,});

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration:  const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.notificationColor,
                    ),
                    child:  Center(
                      child: Text(
                        '${notificationCount ?? 0}',
                        style: AppTextStyle.textStyle7WhiteW500,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15, top: 10),
                  child: Text(
                    AppText.notificationTitle,
                    style: AppTextStyle.textStyle16WhiteW500,
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
