import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/set_attendance_tile/set_attendance_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/student_list_tile/student_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_subject_attendance_search_list_controller.dart';

class AdminSubjectAttendanceSearchListView
    extends GetView<AdminSubjectAttendanceSearchListController> {
  const AdminSubjectAttendanceSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Set Attendance",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "Student Attendance not done yet.\nSelect Present/Absent/Late/Half Day"),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: const Text(
                        "Mark Holiday",
                        style: AppTextStyle.textStyle12WhiteW400,
                      ),
                    ),
                  )
                ],
              ),
              10.verticalSpacing,
              Expanded(
                child: ListView.builder(
                  itemCount: controller.adminClassSetAttendanceUIModel.length,
                  itemBuilder: (context, index) {

                    var data = controller
                        .adminClassSetAttendanceUIModel[index];

                    return SetAttendanceTile(
                      studentName: "Jalil",
                      section:"B",
                      studentClass:"One",
                      imageUrl: "Bhai model update korle boshay niyen",
                      onPresentButtonTap: () {

                      },
                      onAbsentButtonTap: () {

                      },
                      onLateButtonTap: () {

                      },
                      onHalfDayButtonTap: () {

                      },
                      adminClassSetAttendanceUIModel: data,
                    );
                  },
                ),
              ),
              30.verticalSpacing,
              PrimaryButton(
                text: "Save",
                onTap: () {},
              ),
              30.verticalSpacing
            ],
          ),
        ),
      ),
    );
  }
}
