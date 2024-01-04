import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/credit_card.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/fees_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/fees/views/widget/two_value_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/student_wallet/controllers/student_wallet_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/custom_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_fees_response_model/student_fees_response_model.dart';
import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';

class FeesController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  StudentWalletController studentWalletController =
      Get.put(StudentWalletController());

  TextEditingController noteTextController = TextEditingController();

  // LoadingController loadingController = Get.find();
  RxBool feesLoader = false.obs;
  HomeController homeController = Get.find();

  RxInt recordId = 0.obs;
  final selectIndex = RxInt(0);

  List<FeesInvoice> feesInvoiceList = [];

  Future<StudentFeesInvoiceResponseModel?> getAllFeesList(
      {required int studentId, required int recordId}) async {
    feesInvoiceList.clear();
    try {
      feesLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentFeesList(
            studentId: studentId, recordId: recordId),
        header: GlobalVariable.header,
      );

      StudentFeesInvoiceResponseModel studentFeesInvoiceResponseModel =
          StudentFeesInvoiceResponseModel.fromJson(response);
      if (studentFeesInvoiceResponseModel.success == true) {
        feesLoader.value = false;
        if (studentFeesInvoiceResponseModel.data!.feesInvoice!.isNotEmpty) {
          for (int i = 0;
              i < studentFeesInvoiceResponseModel.data!.feesInvoice!.length;
              i++) {
            feesInvoiceList
                .add(studentFeesInvoiceResponseModel.data!.feesInvoice![i]);
          }
        }
      } else {
        feesLoader.value = false;
        showBasicFailedSnackBar(
          message: studentFeesInvoiceResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      feesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      feesLoader.value = false;
    }
    return StudentFeesInvoiceResponseModel();
  }

  void showFeesDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason:",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
              ),
              const BottomSheetTile(
                title: "Leave From",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void showInvoice({required int index}) {
    Get.dialog(
      Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                20.verticalSpacing,
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        ImagePath.back,
                        scale: 4,
                        color: Colors.black,
                      ),
                    ),
                    20.horizontalSpacing,
                    const Text(
                      "Invoice",
                      style: AppTextStyle.fontSize16lightBlackW500,
                    ),
                  ],
                ),
                20.verticalSpacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImagePath.appLogo,
                      height: Get.height * 0.2,
                      width: Get.width * 0.3,
                      color: AppColors.primaryColor,
                    ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Invoice: ",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        5.verticalSpacing,
                        const Text(
                          "Created Date: ",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        5.verticalSpacing,
                        const Text(
                          "Due Date: ",
                          style: AppTextStyle.fontSize13BlackW400,
                        ),

                      ],
                    )
                  ],
                ),
                30.verticalSpacing,
                const FeesTile(
                  statusText: "Partial",
                  statusColor: Colors.green,
                  duration: "Monthly",
                  amount: "2000",
                  paid: "100",
                  fine: "100",
                  waiver: "100",
                  subTotal: "100",
                  isInvoice: true,

                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      TwoValueTile(
                        title: "Total Amount",
                        amount: 1000,
                      ),
                      TwoValueTile(
                        title: "Total Waiver",
                        amount: 1000,
                      ),
                      TwoValueTile(
                        title: "Total Fine",
                        amount: 1000,
                      ),
                      TwoValueTile(
                        title: "Total Paid",
                        amount: 1000,
                      ),
                      TwoValueTile(
                        title: "Grand Total",
                        amount: 1000,
                      ),
                      TwoValueTile(
                        title: "Due Balance",
                        amount: 1000,
                        isDueBalance: true,
                      ),
                      CreditCard(
                        bankName: "Bank Alfalah",
                        accountName: "Zakirashdjashdjkahsjkdhajkshdjkashdjkhajk",
                        accountNumber: 12931290390123000102912,
                        type: "Savings",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAddPayment({required int index}) {
    Get.dialog(
      Material(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpacing,
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          ImagePath.back,
                          scale: 4,
                          color: Colors.black,
                        ),
                      ),
                      20.horizontalSpacing,
                      const Text(
                        "Add Payment",
                        style: AppTextStyle.fontSize16lightBlackW500,
                      ),
                    ],
                  ),
                  30.verticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        ImagePath.appLogo,
                        height: Get.height * 0.2,
                        width: Get.width * 0.3,
                        color: AppColors.primaryColor,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Invoice: ",
                            style: AppTextStyle.fontSize13BlackW400,
                          ),
                          Text(
                            "Due Date: ",
                            style: AppTextStyle.fontSize13BlackW400,
                          ),
                          Text(
                            "Wallet Balance: ",
                            style: AppTextStyle.blackFontSize14W400,
                          ),
                          Text(
                            "Add in wallet: ",
                            style: AppTextStyle.blackFontSize14W400,
                          ),
                        ],
                      )
                    ],
                  ),
                  30.verticalSpacing,
                  const Text(
                    "Fees List",
                    style: AppTextStyle.blackFontSize14W400,
                  ),
                  20.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: studentWalletController.initValue.value,
                    dropdownList: studentWalletController.paymentMethodList,
                    changeDropdownValue: (value) {
                      studentWalletController.initValue.value = value!;
                    },
                  ),
                  10.verticalSpacing,
                  studentWalletController.initValue.value == "Bank"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: studentWalletController.bankListLoader.value
                              ? const SecondaryLoadingWidget()
                              : DuplicateDropdown(
                                  dropdownValue: studentWalletController
                                      .initBankValue.value,
                                  dropdownList:
                                      studentWalletController.bankList,
                                  changeDropdownValue: (value) {
                                    studentWalletController
                                        .initBankValue.value = value!;
                                    studentWalletController.bankId.value =
                                        value.id;
                                  },
                                ),
                        )
                      : const SizedBox(),
                  studentWalletController.initValue.value == "Bank" ?  10.verticalSpacing : const SizedBox(),
                  studentWalletController.initValue.value == "Bank" ||
                          studentWalletController.initValue.value == "Cheque"
                      ? CustomTextFormField(
                          controller: noteTextController,
                          enableBorderActive: true,
                          focusBorderActive: true,
                          hintText: "Note",
                          textInputType: TextInputType.number,
                          hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                          fillColor: Colors.white,
                        )
                      : const SizedBox(),
                  studentWalletController.initValue.value == "Bank" ?  10.verticalSpacing : const SizedBox(),
                  studentWalletController.initValue.value == "Bank" ||
                          studentWalletController.initValue.value == "Cheque"
                      ? CustomTextFormField(
                          enableBorderActive: true,
                          focusBorderActive: true,
                          hintText:
                              "${studentWalletController.file.value.path.isNotEmpty ? studentWalletController.file : 'Select File'}",
                          fillColor: Colors.white,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Browse",
                                  style:
                                      AppTextStyle.fontSize12lightViolateW400,
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
                            studentWalletController.pickFile();
                            debugPrint(
                                "Browser ::: ${studentWalletController..file}");
                          },
                          hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                        )
                      : const SizedBox(),
                  30.verticalSpacing,
                  PrimaryButton(
                    text: 'Submit',
                    onTap: () {
                      if (studentWalletController.validation()) {}
                    },
                    padding: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      getAllFeesList(
        studentId: globalRxVariableController.studentId.value!,
        recordId: globalRxVariableController.studentRecordId.value!,
      );
    }

    super.onInit();
  }
}
