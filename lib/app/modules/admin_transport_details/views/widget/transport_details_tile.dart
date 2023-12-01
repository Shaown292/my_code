import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class TransportDetailsTile extends StatelessWidget {
  final String? route;
  final String? vehicleNo;

  final Function()? onTap;

  const TransportDetailsTile({
    super.key,
    this.route,
    this.vehicleNo,
   this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: Text(
                  "Routes: ${route ?? ""}",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ),
              InkWell(
                onTap: onTap,
                child:  Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.primaryColor,
                  ),
                  child: const Text(
                    "View",
                    style: AppTextStyle.textStyle12WhiteW400,
                  ),
                ),
              )
            ],
          ),
          10.verticalSpacing,
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              "Vehicle No: ${vehicleNo ?? ""}",
              style: AppTextStyle.fontSize13BlackW400,
            ),
          ),
          10.verticalSpacing,
          const CustomDivider(
            color: AppColors.customDividerColor,
          ),

        ],
      ),
    );
  }
}
