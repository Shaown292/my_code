import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_fees_model/admin_fees_type_response_model.dart';
import 'package:get/get.dart';

class AdminFeesTypeController extends GetxController {

  LoadingController loadingController = Get.find();

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxList<FeesTypes> feesTypeList = <FeesTypes>[].obs;

  Future<AdminFeesTypeResponseModel> getFeesListList() async {
    try {
      feesTypeList.clear();
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
          url: InfixApi.getFeesTypeList, header: GlobalVariable.header);
      AdminFeesTypeResponseModel feesTypeResponseModel =
      AdminFeesTypeResponseModel.fromJson(response);

      if (feesTypeResponseModel.success == true) {
        if (feesTypeResponseModel.data!.feesTypes!.isNotEmpty) {
          for (int i = 0; i < feesTypeResponseModel.data!.feesTypes!.length; i++) {
            feesTypeList.add(feesTypeResponseModel.data!.feesTypes![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message:
            feesTypeResponseModel.message ?? 'Something Went Wrong.');
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminFeesTypeResponseModel();
  }


  void showUploadDocumentsBottomSheet({
    Function()? onTapForSave,
    Color? bottomSheetBackgroundColor,
    String? header,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    Function()? onTapCancel,
  }) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.45,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: bottomSheetBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      header ?? "",
                      style: AppTextStyle.cardTextStyle14WhiteW500,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          titleTextController.clear();
                          descriptionTextController.clear();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: titleController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "Title",
                      fillColor: Colors.white,
                    ),
                    10.verticalSpacing,
                    CustomTextFormField(
                      controller: descriptionController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      fillColor: Colors.white,
                      hintText: "Descriptions",
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      width: Get.width * 0.15,
                      title: "Cancel",
                      color: Colors.white,
                      textStyle: AppTextStyle.fontSize13BlackW400,
                      borderColor: AppColors.primaryColor,
                      onTap: onTapCancel,
                    ),
                    PrimaryButton(
                      width: Get.width * 0.2,
                      title: "Save",
                      textStyle: AppTextStyle.textStyle12WhiteW500,
                      onTap: onTapForSave,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }


  @override
  void onInit() {
    getFeesListList();
    super.onInit();
  }

}
