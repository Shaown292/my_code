import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_attendance_model/admin_set_attendance_ui_model.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class SetAttendanceTile extends StatelessWidget {
  final AdminSetAttendanceUIModel adminClassSetAttendanceUIModel;
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
    required this.adminClassSetAttendanceUIModel,
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
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 4,
                    //     itemBuilder: (context, index) {
                    //       return RadioListTile(
                    //           title: const Text("Present"),
                    //           groupValue: title,
                    //           onChanged: onChanged,
                    //           value: value[id],
                    //     },
                    //   ),
                    // )
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
                                  color: adminClassSetAttendanceUIModel.attendanceType == "P"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: adminClassSetAttendanceUIModel.attendanceType == "P"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Present",
                                  style: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "P"
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
                                  color: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "A"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: adminClassSetAttendanceUIModel
                                              .attendanceType ==
                                          "A"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Absent",
                                  style: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "A"
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
                                color: adminClassSetAttendanceUIModel
                                                .attendanceType ==
                                            "L"
                                    ? Colors.transparent
                                    : AppColors.primaryColor,
                              ),
                              color: adminClassSetAttendanceUIModel
                                              .attendanceType ==
                                          "L"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Late",
                                  style: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "L"
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
                                  color: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "H"
                                      ? Colors.transparent
                                      : AppColors.primaryColor),
                              color: adminClassSetAttendanceUIModel
                                              .attendanceType ==
                                          "H"
                                  ? AppColors.appButtonColor
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Half day",
                                  style: adminClassSetAttendanceUIModel
                                                  .attendanceType ==
                                              "H"
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
