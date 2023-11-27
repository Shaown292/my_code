import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class SetAttendanceTile extends StatelessWidget {
  final bool isImageEmpty;
  final String? imageUrl;
  final String? studentName;
  final String? studentClass;
  final String? section;
  final Function()? onPresentButtonTap;
  final Function()? onAbsentButtonTap;
  final Function()? onLateButtonTap;
  final Function()? onHalfDayButtonTap;
  final String status;
  final bool isSelected;
  final String? title;
  final String? value;
  final String? groupValue;
  final Function(String? value)? onChanged;

  const SetAttendanceTile({
    super.key,
    this.isImageEmpty = false,
    this.imageUrl,
    this.studentName,
    this.studentClass,
    this.section,
    this.onPresentButtonTap,
    this.status = "P",
    this.onAbsentButtonTap,
    this.onLateButtonTap,
    this.onHalfDayButtonTap,
    this.isSelected = false, this.title, this.value, this.groupValue, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            10.horizontalSpacing,
            isImageEmpty
                ? Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                child: CacheImageView(
                  url: imageUrl,
                  errorImageLocal: ImagePath.dp,
                ),
              ),
            )
                : Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(ImagePath.dp),
                ),
              ),
            ),
            10.horizontalSpacing,
            Flexible(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentName ?? ""),
                    10.verticalSpacing,
                    Text("Class: $studentClass  |  Section: $section"),
                    10.verticalSpacing,
                    // SizedBox(
                    //   height: 100,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       RadioListTile(
                    //         title: Text(title ?? ""),
                    //         value: value,
                    //         groupValue: groupValue,
                    //         onChanged:  (value) {
                    //
                    //         } ,
                    //       ),
                    //       RadioListTile(
                    //         title: Text(title ?? ""),
                    //         value: value,
                    //         groupValue: groupValue,
                    //         onChanged:  (value) {
                    //
                    //         } ,
                    //       ),
                    //       RadioListTile(
                    //         title: Text(title ?? ""),
                    //         value: value,
                    //         groupValue: groupValue,
                    //         onChanged:  (value) {
                    //
                    //         } ,
                    //       ),
                    //       RadioListTile(
                    //         title: Text(title ?? ""),
                    //         value: value,
                    //         groupValue: groupValue,
                    //         onChanged:  (value) {
                    //
                    //         } ,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Present
                        InkWell(
                          onTap: onPresentButtonTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  width: 1,
                                  color: status == "P" && isSelected
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: status == "P" && isSelected
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Present",
                                  style: status == "P" && isSelected
                                      ? AppTextStyle.textStyle12WhiteW500
                                      : AppTextStyle.cardTextStyle12PurpleW400,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Absent
                        InkWell(
                          onTap: onAbsentButtonTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  width: 1,
                                  color: status == "A" && isSelected
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: status == "A" && isSelected
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Absent",
                                  style: status == "A" && isSelected
                                      ? AppTextStyle.textStyle12WhiteW500
                                      : AppTextStyle.cardTextStyle12PurpleW400,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Late
                        InkWell(
                          onTap: onLateButtonTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  width: 1,
                                  color: status == "L" && isSelected
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: status == "L" && isSelected
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Late",
                                  style: status == "L" && isSelected
                                      ? AppTextStyle.textStyle12WhiteW500
                                      : AppTextStyle.cardTextStyle12PurpleW400,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Half Day
                        InkWell(
                          onTap: onHalfDayButtonTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  width: 1,
                                  color: status == "H" && isSelected
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: status == "H" && isSelected
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Half day",
                                  style: status == "H" && isSelected
                                      ? AppTextStyle.textStyle12WhiteW500
                                      : AppTextStyle.cardTextStyle12PurpleW400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        10.verticalSpacing,
        CustomDivider(
          width: Get.width,
          color: AppColors.dormitoryDividerColor,
        )
      ],
    );
  }
}
