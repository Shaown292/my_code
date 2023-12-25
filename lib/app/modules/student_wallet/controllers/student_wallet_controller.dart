import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:get/get.dart';

class StudentWalletController extends GetxController {
  TextEditingController amountTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  RxString initValue = "PayPal".obs;
  RxList<String> paymentMethodList =
      ['PayPal', 'PayTm', 'Stripe', 'Paystack', 'Bank', 'Cheque'].obs;
  RxString initBankValue = "Dutch Bangla Bank".obs;
  RxList<String> bankList = [
    'Dutch Bangla Bank',
    'Bank Asia',
    'UCB Bank',
  ].obs;

  void showAddBalanceBottomSheet(
      {required Color color,
      required TextEditingController amountController,
      required TextEditingController noteController}) {
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
