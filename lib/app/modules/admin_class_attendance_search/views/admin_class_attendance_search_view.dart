import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_controller.dart';

class AdminClassAttendanceSearchView
    extends GetView<AdminClassAttendanceSearchController> {
  const AdminClassAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Class Attendance Search",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                CustomDropdown(
                  dropdownValue: controller.classList.isEmpty ? controller.classNullValue.value : controller.classInitialValue.value,
                  dropdownList: controller.classList,
                  changeDropdownValue: (v) {
                    controller.classInitialValue.value = v!;
                  },
                ),
                10.verticalSpacing,
                CustomDropdown(
                  dropdownValue: controller.sectionList.isEmpty ? controller.sectionNullValue.value : controller.sectionInitialValue.value,
                  dropdownList: controller.sectionList,
                  changeDropdownValue: (v) {
                    controller.sectionInitialValue.value = v!;
                  },
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  iconOnTap: () {
                    controller.selectDate();
                  },
                  readOnly: true,
                  controller: controller.selectedDateTextController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Select Date *",
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                  suffixIcon: Image.asset(
                    ImagePath.calender,
                    color: AppColors.profileValueColor,
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: "Search",
                  onTap: () {
                    if(controller.validation()){
                      Get.toNamed(Routes.ADMIN_CLASS_SET_ATTENDANCE);
                    }
                  },
                ),
                50.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
