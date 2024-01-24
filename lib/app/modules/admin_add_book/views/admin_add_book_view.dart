import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpacing,
                  const Text("Add Book Category*", style: AppTextStyle.fontSize13BlackW400,),
                  5.verticalSpacing,
                  /// Book Category dropdown List
                  controller.loadingController.isLoading
                      ? const SecondaryLoadingWidget()
                      : DuplicateDropdown(
                          dropdownValue: controller.bookCategoryInitValue.value,
                          dropdownList: controller.bookCategoryList,
                          changeDropdownValue: (value) {
                            controller.bookCategoryInitValue.value = value!;
                            controller.bookCategoryId.value = value.id;
                          },
                        ),
                  10.verticalSpacing,
                  const Text("Add Subject*", style: AppTextStyle.fontSize13BlackW400,),
                  5.verticalSpacing,
                  /// Book Subject dropdown List
                  DuplicateDropdown(
                    dropdownValue: controller.bookSubjectInitValue.value,
                    dropdownList: controller.bookSubjectList,
                    changeDropdownValue: (value) {
                      controller.bookSubjectInitValue.value = value!;
                      controller.bookSubjectId.value = value.id;
                    },
                  ),
                  10.verticalSpacing,

                  /// Book title Text Field
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Title*",
                    // hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
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
                    iconOnTap: () {
                      controller.changeApplyDate();
                    },
                    readOnly: true,
                    controller: controller.dateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Select Upload Date",
                    fillColor: Colors.white,
                    suffixIcon: Image.asset(
                      ImagePath.calender,
                      color: AppColors.profileValueColor,
                    ),
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
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

                  (Get.height * 0.2).verticalSpacing,
                  controller.addBookLoader.value ?
                  const SecondaryLoadingWidget(isBottomNav: true,) :
                  PrimaryButton(
                    text: "Save",
                    onTap: () {
                      if (controller.validation()) {
                        controller.addAdminBook(
                          bookCategoryId: controller.bookCategoryId.value,
                          bookSubjectId: controller.bookSubjectId.value,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),


      ),
    );
  }
}
