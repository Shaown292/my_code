

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/dummy_data/student/student_info_dummy_data.dart';

class PersonalProfileWidget extends StatelessWidget {

   const PersonalProfileWidget({super.key, required this.studentInfo});
   final List<StudentInfoPersonalModelClass> studentInfo;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: studentInfo.length,
        itemBuilder: (context, index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(studentInfo[index].icon))),
                      ),
                      10.horizontalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             studentInfo[index].title,
                            style: const TextStyle(
                                color: AppColors.profileTitleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            studentInfo[index].value,
                            style: const TextStyle(
                                color: AppColors.profileValueColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.verticalSpacing,
                  CustomDivider(
                    width: Get.width,
                    color: AppColors.profileDividerColor,
                  )
                ],
              ),

            ],
          );
        },
        separatorBuilder: (context, index){
          return 5.verticalSpacing;
        },
    );
  }
}
