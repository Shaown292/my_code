import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_book_controller.dart';

class AdminAddBookView extends GetView<AdminAddBookController> {
  const AdminAddBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Book",
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.verticalSpacing,

                  /// Book Category dropdown List
                  CustomDropdown(
                    dropdownValue: controller.categoryInitValue.value,
                    dropdownList: controller.categoryList,
                    changeDropdownValue: (value) {
                      controller.categoryInitValue.value = value!;
                    },
                  ),
                  10.verticalSpacing,

                  /// Book Gerne dropdown List
                  CustomDropdown(
                    dropdownValue: controller.audienceInitValue.value,
                    dropdownList: controller.audienceList,
                    changeDropdownValue: (value) {
                      controller.audienceInitValue.value = value!;
                    },
                  ),
                  10.verticalSpacing,

                  /// Book title Text Field
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Title",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Book Number Text Field
                  CustomTextFormField(
                    controller: controller.bookNumberTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Book Number",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                  ),
                  10.verticalSpacing,

                  /// ISBN Text Field
                  CustomTextFormField(
                    controller: controller.isbnTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "ISBN",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  ///Publisher Name Text Field
                  CustomTextFormField(
                    controller: controller.publisherNameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Publisher Name",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Author Name Text Field
                  CustomTextFormField(
                    controller: controller.authorNameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Author Name",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Rack Number Text Field
                  CustomTextFormField(
                    controller: controller.rackNumberTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Rack Number",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Quantity Text Field
                  CustomTextFormField(
                    controller: controller.quantityTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Quantity",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Price Text Field
                  CustomTextFormField(
                    controller: controller.priceTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Price",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Date Text Field
                  CustomTextFormField(
                    controller: controller.dateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Date",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Description Text Field
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Description",
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),

                  30.verticalSpacing,
                  PrimaryButton(
                    text: "Save",
                    onTap: () {},
                  ),
                  40.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
