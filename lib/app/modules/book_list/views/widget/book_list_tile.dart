import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class BookListTile extends StatelessWidget {
  final String? bookName;
  final String? subject;
  final String? bookNumber;
  final Color? color;
  final Function()? onTap;

  const BookListTile({
    super.key,
    this.bookName,
    this.subject,
    this.bookNumber,
    this.color, this.onTap,
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
                      bookNumber ?? "",
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
                      subject ?? "",
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
                          bookName ?? "",
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
