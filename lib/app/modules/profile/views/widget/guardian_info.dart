import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/guardian_items_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class GuardianInfo extends StatelessWidget {
  final String? designation;
  final String? icon;
  final String? name;
  final String? email;
  final String? phone;
  final String? occupation;
  final String? relation;
  final String? other;
  final String? imageUrl;
  final int? permissionForPhoto;
  final int? permissionForName;
  final int? permissionForEmail;
  final int? permissionForPhone;
  final int? permissionForOccupation;

  const GuardianInfo({
    super.key,
    this.designation,
    this.icon,
    this.name,
    this.email,
    this.phone,
    this.occupation,
    this.relation,
    this.other,
    this.permissionForPhoto,
    this.permissionForName,
    this.permissionForEmail,
    this.permissionForPhone,
    this.permissionForOccupation,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Container(
        height: Get.height * 0.2,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.parentsCardBorderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.16,
              decoration: BoxDecoration(
                color: AppColors.parentsIconCardBackgroundColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Padding(
                padding: EdgeInsets.all(Get.width * 0.02),
                child: SizedBox(
                  width: Get.width * 0.19,
                  child: Column(
                    children: [
                      5.verticalSpacing,
                      Text(
                        designation ?? "",
                        style: const TextStyle(
                            color: AppColors.parentsDesignationColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      15.verticalSpacing,
                      permissionForPhoto == 1
                          ? imageUrl != "" || imageUrl != null
                              ? SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipRRect(
                                    borderRadius: 8.circularRadius,
                                    child: CacheImageView(
                                      url: imageUrl,
                                      errorImageLocal: ImagePath.errorImage,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.profilePicBackgroundColor,
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    image: DecorationImage(
                                        image: AssetImage(icon ?? ImagePath.dp),
                                        fit: BoxFit.contain),
                                  ),
                                )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Get.width * .05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                permissionForName == 1
                    ? GuardianItemWidget(title: name ?? AppText.noDataAvailable)
                    : const SizedBox(),
                permissionForName == 1 ? 10.verticalSpacing : 0.verticalSpacing,
                permissionForEmail == 1
                    ? GuardianItemWidget(
                        title: email ?? AppText.noDataAvailable)
                    : const SizedBox(),
                permissionForEmail == 1
                    ? 10.verticalSpacing
                    : 0.verticalSpacing,
                permissionForPhone == 1
                    ? GuardianItemWidget(
                        title: phone ?? AppText.noDataAvailable)
                    : const SizedBox(),
                permissionForPhone == 1
                    ? 10.verticalSpacing
                    : 0.verticalSpacing,
                permissionForOccupation == 1
                    ? GuardianItemWidget(
                        title: occupation ?? AppText.noDataAvailable)
                    : const SizedBox(),
                permissionForOccupation == 1
                    ? 10.verticalSpacing
                    : 0.verticalSpacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          relation ?? AppText.noDataAvailable,
                          style: const TextStyle(
                              color: AppColors.profileValueColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        5.verticalSpacing,
                        CustomDivider(
                          color: AppColors.profileDividerColor,
                          width: Get.width * 0.25,
                        ),
                      ],
                    ),
                    20.horizontalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          other ?? AppText.noDataAvailable,
                          style: const TextStyle(
                              color: AppColors.profileValueColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        5.verticalSpacing,
                        CustomDivider(
                          color: AppColors.profileDividerColor,
                          width: Get.width * 0.25,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
