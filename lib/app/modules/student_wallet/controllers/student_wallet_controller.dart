import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:get/get.dart';

class StudentWalletController extends GetxController {
  TextEditingController amountTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController browseFileTextController = TextEditingController();

  Rx<File> file = File('').obs;
  RxString initValue = "PayPal".obs;
  RxList<String> paymentMethodList =
      ['PayPal', 'PayTm', 'Stripe', 'Paystack', 'Bank', 'Cheque'].obs;
  RxString initBankValue = "Dutch Bangla Bank".obs;
  RxList<String> bankList = [
    'Dutch Bangla Bank',
    'Bank Asia',
    'UCB Bank',
  ].obs;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      file.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }

  void showAddBalanceBottomSheet({
    required Color color,
    required TextEditingController amountController,
    required TextEditingController noteController,
    required TextEditingController browseFileTextController,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          color: color,
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(15),
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.verticalSpacing,
                const Text(
                  "Add Balance",
                  style: AppTextStyle.fontSize14BlackW500,
                ),
                10.verticalSpacing,
                CustomTextFormField(
                  controller: amountController,
                  enableBorderActive: true,
                  focusBorderActive: true,
                  hintText: "Amount",
                  textInputType: TextInputType.number,
                  hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  fillColor: Colors.white,
                ),
                10.verticalSpacing,
                CustomDropdown(
                  dropdownValue: initValue.value,
                  dropdownList: paymentMethodList,
                  changeDropdownValue: (value) {
                    initValue.value = value!;
                  },
                ),
                initValue.value == "Bank"
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomDropdown(
                          dropdownValue: initBankValue.value,
                          dropdownList: bankList,
                          changeDropdownValue: (value) {
                            initValue.value = value!;
                          },
                        ),
                      )
                    : const SizedBox(),
                10.verticalSpacing,
                initValue.value == "Bank" || initValue.value == "Cheque"
                    ? CustomTextFormField(
                        controller: noteController,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Note",
                        textInputType: TextInputType.number,
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                        fillColor: Colors.white,
                      )
                    : const SizedBox(),
                10.verticalSpacing,
                initValue.value == "Bank" || initValue.value == "Cheque"
                    ? CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText:
                            "${file.value.path.isNotEmpty ? file : 'Select File'}",
                        fillColor: Colors.white,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Browse",
                                style: AppTextStyle.fontSize12lightViolateW400,
                              ),
                              CustomDivider(
                                width: 42,
                                height: 1,
                                color: AppColors.profileValueColor,
                              ),
                            ],
                          ),
                        ),
                        iconOnTap: () {
                          pickFile();
                          debugPrint("Browser ::: $file");
                        },
                        hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                      )
                    : const SizedBox(),
                30.verticalSpacing,
                PrimaryButton(
                  text: 'Submit',
                  onTap: () {
                    if (validation()) {}
                  },
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  bool validation() {
    if (amountTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter an amount');
      return false;
    }

    return true;
  }
}
