
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/parents_item_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ParentsInfo extends StatelessWidget {
  const ParentsInfo({super.key, required this.designation, required this.icon, required this.name, required this.phone, required this.occupation});

  final String designation;
  final String icon;
  final String name;
  final String phone;
  final String occupation;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Container(
        height: Get.height * 0.135,
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: AppColors.parentsCardBorderColor
            )
        ),
        child: Padding(
          padding:  const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.13,
                width: Get.width * 0.14,
                decoration:  BoxDecoration(
                  color: AppColors.parentsIconCardBackgroundColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(Get.width * 0.02),
                  child: SizedBox(
                    height: Get.height * 2,
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
              ),
             SizedBox(width: Get.width * 0.05,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   ParentsItemWidget(title: name),
                   10.verticalSpacing,
                   ParentsItemWidget(title: phone),
                   10.verticalSpacing,
                   ParentsItemWidget(title: occupation),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}