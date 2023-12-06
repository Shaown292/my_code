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
  final String? title;
  final String? groupValue;
  final String? value;
  final Function(String? value)? onChanged;
  final int? index;
  final String attendanceType;

  const SetAttendanceTile({
    super.key,
    this.isImageEmpty = false,
    this.imageUrl,
    this.studentName,
    this.studentClass,
    this.section,
    this.onPresentButtonTap,
    this.onAbsentButtonTap,
    this.onLateButtonTap,
    this.onHalfDayButtonTap,
    this.title,
    this.groupValue,
    this.onChanged,
    this.index,
    this.value,
    required this.attendanceType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            
            isImageEmpty
                ? Container(
                    width: Get.width * 0.05,
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
                    height: Get.width * 0.15,
                    width: Get.width * 0.15,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(ImagePath.dp),
                      ),
                    ),
                  ),
            5.horizontalSpacing,
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentName ?? ""),
                    8.verticalSpacing,
                    Text("Class: $studentClass  |  Section: $section"),
                    8.verticalSpacing,
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
                                  color: attendanceType == "P"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: attendanceType == "P"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Present",
                                  style: attendanceType == "P"
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
                                  color: attendanceType == "A"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: attendanceType == "A"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Absent",
                                  style: attendanceType == "A"
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
                                color: attendanceType == "L"
                                    ? Colors.transparent
                                    : AppColors.primaryColor,
                              ),
                              color: attendanceType == "L"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Late",
                                  style: attendanceType == "L"
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
                                  color: attendanceType == "H"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: attendanceType == "H"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Half day",
                                  style: attendanceType == "H"
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
          color: AppColors.customDividerColor,
        )
      ],
    );
  }
}
