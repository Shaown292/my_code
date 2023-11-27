import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class IndividualDetailsTile extends StatelessWidget {
  final String? address;
  final String? phone;
  final String? title;
  final String? qualification;
  final String? maritalStatus;
  final String? joiningDate;

  const IndividualDetailsTile({
    super.key,
    this.address,
    this.phone,
    this.title,
    this.qualification,
    this.maritalStatus,
    this.joiningDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address: ${address ?? ""}",
                style: AppTextStyle.fontSize13BlackW400,
              ),
              10.verticalSpacing,
              Text(
                "Phone: ${phone ?? ""}",
                style: AppTextStyle.fontSize13BlackW400,
              ),
            ],
          ),
        ),
        10.verticalSpacing,
        CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Title: ${title ?? ""}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Qualification: ${qualification ?? ""}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Marital Status: ${maritalStatus ?? ""}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Joining Date: ${joiningDate ?? ""}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
      ],
    );
  }
}
