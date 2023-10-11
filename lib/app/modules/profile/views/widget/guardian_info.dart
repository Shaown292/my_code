
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class GuardianInfo extends StatelessWidget {

  const GuardianInfo({super.key, required this.designation, required this.icon, required this.name, required this.email, required this.phone, required this.occupation, required this.relation, required this.other});

  final String designation;
  final String icon;
  final String name;
  final String email;
  final String phone;
  final String occupation;
  final String relation;
  final String other;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColors.parentsCardBorderColor
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.17,
            width: Get.width * 0.16,
            decoration:  BoxDecoration(
              color: AppColors.parentsIconCardBackgroundColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: SizedBox(
              width: Get.width * 0.2,
              child: Column(
                children: [
                  10.verticalSpacing,
                  Text(
                    designation,
                    style: const TextStyle(
                        color: AppColors.parentsDesignationColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                  8.verticalSpacing,
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: Colors.white
                      ),
                      shape: BoxShape.circle,
                      color: const Color(0xFF556080),
                      image: DecorationImage(
                          image: AssetImage(icon)),
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(width: Get.width * .05,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:  const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width * 0.55,
              ),
              10.verticalSpacing,
              Text(
                email,
                style:  const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width * 0.55,
              ),
              10.verticalSpacing,
              Text(
                phone,
                style:  const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width * 0.55,
              ),
              10.verticalSpacing,
              Text(
                occupation,
                style:  const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width * 0.55,
              ),
              10.verticalSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        relation,
                        style:  const TextStyle(
                            color: AppColors.profileTitleColor,
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
                        other,
                        style:  const TextStyle(
                            color: AppColors.profileTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
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
    );
  }
}