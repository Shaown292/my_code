import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student/wallet/bank_list/bank_list.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student/wallet/my_wallet/my_wallet.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student/wallet/payment_method_list/payment_method_list_response_model.dart';
import 'package:get/get.dart';

class StudentWalletController extends GetxController {
  RxBool paymentMethodLoader = false.obs;
  RxBool bankListLoader = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController amountTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TextEditingController browseFileTextController = TextEditingController();

  Rx<File> file = File('').obs;
  RxString initValue = "".obs;
  List<String> paymentMethodList = [];

  RxList<BankList> bankList = <BankList>[].obs;
  Rx<BankList> initBankValue = BankList(id: -1, name: "Bank Name").obs;
  RxInt bankId = (-1).obs;

  RxList<WalletTransactions> paymentList = <WalletTransactions>[].obs;
  RxString balance = ''.obs;

  Future<MyWalletModel> getPaymentDetails() async {
    try {
      isLoading.value = true;

      final response = await BaseClient()
          .getData(url: InfixApi.getPaymentList, header: GlobalVariable.header);

      MyWalletModel myWalletModel = MyWalletModel.fromJson(response);

      if (myWalletModel.success == true) {
        isLoading.value = false;
        balance.value =
            '${myWalletModel.data!.first.currencySymbol}${myWalletModel.data!.first.myBalance}';
        for (int i = 0;
            i < myWalletModel.data!.first.walletTransactions!.length;
            i++) {
          paymentList.add(myWalletModel.data!.first.walletTransactions![i]);
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('$e');
    }

    return MyWalletModel();
  }

  Future<PaymentMethodListResponseModel> getPaymentMethod() async {
    try {
      paymentMethodLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getPaymentMethodList, header: GlobalVariable.header);

      PaymentMethodListResponseModel paymentMethodListResponseModel =
          PaymentMethodListResponseModel.fromJson(response);

      if (paymentMethodListResponseModel.success == true) {
        paymentMethodLoader.value = false;
        for (int i = 0; i < paymentMethodListResponseModel.data!.length; i++) {
          paymentMethodList.add(paymentMethodListResponseModel.data![i]);
        }
        initValue.value = paymentMethodList.first;
      }
    } catch (e) {
      paymentMethodLoader.value = false;
      print('$e');
    }

    return PaymentMethodListResponseModel();
  }

  Future<PaymentMethodListResponseModel> getBankList() async {
    try {
      bankListLoader.value = true;

      final response = await BaseClient()
          .getData(url: InfixApi.getBankList, header: GlobalVariable.header);

      BankListResponseModel bankListResponseModel =
          BankListResponseModel.fromJson(response);

      if (bankListResponseModel.success == true) {
        bankListLoader.value = false;
        for (int i = 0; i < bankListResponseModel.data!.length; i++) {
          bankList.add(bankListResponseModel.data![i]);
        }
        initBankValue.value = bankList.first;
        bankId.value = bankList.first.id!;
      }
    } catch (e) {
      bankListLoader.value = false;
      print('$e');
    }

    return PaymentMethodListResponseModel();
  }

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

                /// Payment Method
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
                        child: bankListLoader.value
                            ? const SecondaryLoadingWidget()
                            : DuplicateDropdown(
                                dropdownValue: initBankValue.value,
                                dropdownList: bankList,
                                changeDropdownValue: (value) {
                                  initBankValue.value = value!;
                                  bankId.value = value.id;
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

  @override
  void onInit() {
    getPaymentDetails();
    getPaymentMethod();
    getBankList();

    super.onInit();
  }
}
