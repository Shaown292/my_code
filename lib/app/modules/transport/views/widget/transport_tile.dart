import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class TransportTile extends StatelessWidget {
  final String? vehicle;
  final String? status;
  final String? route;
  final Function()? onTap;

  const TransportTile({
    super.key,
    this.vehicle,
    this.status,
    this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: SizedBox(
            height: Get.height * 0.04,
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.profileCardBackgroundColor),
                  child: Center(
                    child: Text(
                      vehicle ?? "",
                      style: AppTextStyle.textStyle12WhiteW400,
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  width: Get.width * 0.23,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.homeworkStatusGreenColor),
                  child: Center(
                    child: Text(
                      status ?? "",
                      style: AppTextStyle.textStyle12WhiteW400,
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.27,
                        child: Text(
                          route ?? "",
                          style: const TextStyle(
                              color: AppColors.profileTitleColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: AppColors.appButtonColor),
                          child: const Center(
                            child: Text(
                              "View",
                              style: AppTextStyle.textStyle12WhiteW400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.transportDividerColor,
        )
      ],
    );
  }
}
