import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/parents_item_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ParentsInfo extends StatelessWidget {
  final String? designation;
  final String? icon;
  final String? name;
  final String? phone;
  final String? occupation;

  const ParentsInfo({
    super.key,
    this.designation,
    this.icon,
    this.name,
    this.phone,
    this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Container(
        height: Get.height * 0.21,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.parentsCardBorderColor)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  color: AppColors.parentsIconCardBackgroundColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.02),
                  child: SizedBox(
                    height: Get.height * 19,
                    child: Column(
                      children: [
                        10.verticalSpacing,
                        Text(
                          designation ?? AppText.noDataAvailable,
                          style: const TextStyle(
                              color: AppColors.parentsDesignationColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: Get.height * 0.1,
                          width: Get.width * 0.15,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.profilePicBackgroundColor,
                            border: Border.all(
                                width: 1.5,
                                color: Colors.white
                            ),
                            image: DecorationImage(
                              image: AssetImage(icon ?? ImagePath.dp),
                              fit: BoxFit.contain
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
                  ParentsItemWidget(title: name ?? AppText.noDataAvailable),
                  10.verticalSpacing,
                  ParentsItemWidget(title: phone ?? AppText.noDataAvailable),
                  10.verticalSpacing,
                  ParentsItemWidget(title: occupation ?? AppText.noDataAvailable),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
