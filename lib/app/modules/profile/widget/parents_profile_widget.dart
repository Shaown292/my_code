import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';



class ParentsProfileWidget extends StatelessWidget {
  const ParentsProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ParentsInfo(designation: 'Father', icon: ImagePath.parentsProfile, name: 'Md. Rofiku islam', phone: '+8845215555', occupation: 'Farmer'),
        ParentsInfo(designation: 'Mother', icon: ImagePath.parentsProfile, name: 'Mst. Fatema Khatun', phone: '+8845215555', occupation: 'Housewife'),
        GuardianInfo(  designation: 'Guardian', icon: ImagePath.parentsProfile, name: 'Salam molla', email: 'salam@gmail.com', phone: '0464794664', occupation: 'Farmer', relation: 'Brother', other: 'Other',)
      ],
    );
  }
}

class ParentsInfo extends StatelessWidget {
  const ParentsInfo({super.key, required this.designation, required this.icon, required this.name, required this.phone, required this.occupation});

  final String designation;
  final String icon;
  final String name;
  final String phone;
  final String occupation;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: AppColors.parentsCardBorderColor
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 60,
                decoration:  BoxDecoration(
                  color: AppColors.parentsIconCardBackgroundColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
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
                          shape: BoxShape.circle,
                          color: AppColors.profilePicBackgroundColor,
                          border: Border.all(
                              width: 1.5,
                              color: Colors.white
                          ),
                          image: DecorationImage(
                            image: AssetImage(icon),

                          ),

                        ),
                      ),

                    ],
                  ),
                ),
              ),
              20.horizontalSpacing,
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
                    width: Get.width - 152,
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
                    width: Get.width - 152,
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
                    width: Get.width - 152,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 145,
            width: 60,
            decoration:  BoxDecoration(
              color: AppColors.parentsIconCardBackgroundColor,
              borderRadius: BorderRadius.circular(2),
            ),
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
          20.horizontalSpacing,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                  width: Get.width - 168,
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
                  width: Get.width - 168,
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
                  width: Get.width - 168,
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
                  width: Get.width - 168,
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
                          width: Get.width/2 - 95,
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
                        5.verticalSpacing,
                        CustomDivider(
                          color: AppColors.profileDividerColor,
                          width: Get.width*0.27,
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}






