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
        parentsInfo("Father", ImagePath.parentsProfile, 'Md. Rofiku islam', '+8845215555', 'Farmer'),
        parentsInfo("Mother", ImagePath.parentsProfile, 'Mst. Fatema Khatun', '+8845215555', 'Housewife'),
        guardianInfo("Guardian", ImagePath.parentsProfile, "Salam molla", "salam@gmail.com", "0464794664", "Farmer", "Brother", "other")
      ],
    );
  }
}




Widget parentsInfo (String designation, String icon, String name, String phone , String occupation){
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Container(
      decoration:  BoxDecoration(
        color: AppColors.parentsCardBackgroundColor,
        borderRadius: BorderRadius.circular(4)
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
                  style: const TextStyle(
                      color: AppColors.profileTitleColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                5.verticalSpacing,
                  CustomDivider(
                  color: AppColors.profileDividerColor,
                   width: Get.width - 150,
                ),
                10.verticalSpacing,
                Text(
                  phone,
                  style: const TextStyle(
                      color: AppColors.profileTitleColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                5.verticalSpacing,
                 CustomDivider(
                  color: AppColors.profileDividerColor,
                   width: Get.width - 150,
                ),
                10.verticalSpacing,
                Text(
                  occupation,
                  style: const TextStyle(
                      color: AppColors.profileTitleColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                5.verticalSpacing,
                 CustomDivider(
                  color: AppColors.profileDividerColor,
                   width: Get.width - 150,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


Widget guardianInfo (String designation, String icon, String name, String email, String phone , String occupation, String relation, String other){
  return Container(
    padding: const EdgeInsets.all(5),
    decoration:  BoxDecoration(
        color: AppColors.parentsCardBackgroundColor,
        borderRadius: BorderRadius.circular(4)
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
                style: const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width - 146,
              ),
              10.verticalSpacing,
              Text(
                email,
                style: const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width - 146,
              ),
              10.verticalSpacing,
              Text(
                phone,
                style: const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width - 146,
              ),
              10.verticalSpacing,
              Text(
                occupation,
                style: const TextStyle(
                    color: AppColors.profileTitleColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              5.verticalSpacing,
              CustomDivider(
                color: AppColors.profileDividerColor,
                width: Get.width - 146,
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
                        style: const TextStyle(
                            color: AppColors.profileTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      5.verticalSpacing,
                      CustomDivider(
                        color: AppColors.profileDividerColor,
                        width: Get.width/2 - 98,
                      ),
                    ],
                  ),
                  20.horizontalSpacing,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        other,
                        style: const TextStyle(
                            color: AppColors.profileTitleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      5.verticalSpacing,
                      CustomDivider(
                        color: AppColors.profileDividerColor,
                        width: Get.width / 2 - 98,
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




