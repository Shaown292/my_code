import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:get/get.dart';

class StudentWalletController extends GetxController {
  TextEditingController amountTextController = TextEditingController();

  RxString initValue = "PayPal".obs;
  RxList<String> paymentMethodList = ['PayPal', 'PayTm', 'Bkash'].obs;

  void showAddBalanceBottomSheet(
      {required Color color, required TextEditingController controller}) {
    Get.bottomSheet(
      Obx(
        () => Container(
          color: color,
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(15),
          width: Get.width,
          child: Column(
            children: [
              10.verticalSpacing,
              const Text(
                "Add Balance",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              CustomTextFormField(
                controller: controller,
                enableBorderActive: true,
                focusBorderActive: true,
                hintText: "Amount",
                textInputType: TextInputType.number,
                hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                fillColor: Colors.white,
              ),
              20.verticalSpacing,
              CustomDropdown(
                dropdownValue: initValue.value,
                dropdownList: paymentMethodList,
                changeDropdownValue: (value) {
                  initValue.value = value!;
                },
              ),
              30.verticalSpacing,
              PrimaryButton(
                text: 'Submit',
                onTap: () {},
                padding: const EdgeInsets.all(10),
              )
            ],
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }
}
