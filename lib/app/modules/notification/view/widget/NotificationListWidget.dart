

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/notification/notification_model.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../data/dummy_data/student/student_info_dummy_data.dart';

class NotificationListWidget extends StatelessWidget {

  const NotificationListWidget({super.key, required this.unreadNotifications});
  final List<UnreadNotifications> unreadNotifications;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: unreadNotifications.length,
          itemBuilder: (context, index) {

            UnreadNotifications notificationsItem = unreadNotifications[index];

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
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.parentsProfile),
                          ),

                        ),
                      ),
                      20.horizontalSpacing,

                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                               "${notificationsItem.message}",
                              style: AppTextStyle.blackFontSize14W400,

                            ),
                            7.verticalSpacing,
                             Text(
                              notificationsItem.createdAt.toString(),
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
      ),
    );
      
      
  }
}
