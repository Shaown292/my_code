import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_fees_group/controllers/admin_fees_group_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_fees_model/admin_fees_type_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_fees_model/fees_group_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminFeesTypeController extends GetxController {
  // LoadingController loadingController = Get.find();
  AdminFeesGroupController adminFeesGroupController =
      Get.put(AdminFeesGroupController());

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxList<FeesTypes> feesTypeList = <FeesTypes>[].obs;
  Rx<FeesTypes> feesTypeInitialValue = FeesTypes(id: -1, name: "name").obs;
  RxString feesTypeNullValue = "".obs;
  RxBool createUpdateLoader = false.obs;
  RxBool deleteLoader = false.obs;
  RxBool getFeesLoader = false.obs;

  /// Fees List
  Future<AdminFeesTypeResponseModel> getFeesListList() async {
    try {
      feesTypeList.clear();
      getFeesLoader.value = true;
      final response = await BaseClient().getData(
          url: InfixApi.getFeesTypeList, header: GlobalVariable.header);
      AdminFeesTypeResponseModel feesTypeResponseModel =
          AdminFeesTypeResponseModel.fromJson(response);

      if (feesTypeResponseModel.success == true) {
        getFeesLoader.value = false;
        if (feesTypeResponseModel.data!.feesTypes!.isNotEmpty) {
          for (int i = 0;
              i < feesTypeResponseModel.data!.feesTypes!.length;
              i++) {
            feesTypeList.add(feesTypeResponseModel.data!.feesTypes![i]);
          }
        }
      } else {
        getFeesLoader.value = false;
        showBasicFailedSnackBar(
            message: feesTypeResponseModel.message ?? 'Something Went Wrong.');
      }
    } catch (e, t) {
      getFeesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      getFeesLoader.value = false;
    }

    return AdminFeesTypeResponseModel();
  }

  /// Create Fess Type
  Future<void> createFeesType({required int feesGroupId}) async {
    try {
      createUpdateLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.createFeesType,
        header: GlobalVariable.header,
        payload: {
          "name": titleTextController.text,
          "fees_group": feesGroupId,
          "description": descriptionTextController.text,
        },
      );

      AdminFeesTypeResponseModel feesTypeResponseModel =
          AdminFeesTypeResponseModel.fromJson(response);
      if (feesTypeResponseModel.success == true) {
        createUpdateLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: feesTypeResponseModel.message ?? 'Created Successfully');
        if (feesTypeResponseModel.data!.feesTypes!.isNotEmpty) {
          feesTypeList.add(
            FeesTypes(
              id: feesTypeResponseModel.data!.feesTypes!.first.id,
              name: feesTypeResponseModel.data!.feesTypes!.first.name,
              description:
                  feesTypeResponseModel.data!.feesTypes!.first.description,
            ),
          );
        }
        Get.back();
      } else {
        createUpdateLoader.value = false;
        showBasicFailedSnackBar(
            message: feesTypeResponseModel.message ?? 'Something went wrong.');
      }
    } catch (e, t) {
      createUpdateLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      createUpdateLoader.value = false;
    }
  }

  /// Delete Single Fees Type
  Future<void> deleteSingleFeesType(
      {required int feesTypeId, required int index}) async {
    try {
      deleteLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.deleteFeesType(feesTypeId: feesTypeId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteLoader.value = false;
        Get.back();
        feesTypeList.removeAt(index);
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Data deleted');
      } else {
        deleteLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      deleteLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteLoader.value = false;
    }
  }

  /// Update or Edit Fees Type
  Future<void> updateSingleFeesType(
      {required int feesTypeId,
      required int index,
      required int feesGroupId}) async {
    try {
      createUpdateLoader.value = true;

      final response = await BaseClient().postData(
        url: InfixApi.updateSingleFeesType,
        header: GlobalVariable.header,
        payload: {
          "fees_type_id": feesTypeId,
          "name": titleTextController.text,
          "fees_group": feesGroupId,
          "description": descriptionTextController.text,
        },
      );

      AdminFeesTypeResponseModel feesTypeResponseModel =
          AdminFeesTypeResponseModel.fromJson(response);
      if (feesTypeResponseModel.success == true) {
        feesTypeList[index].id =
            feesTypeResponseModel.data!.feesTypes!.first.id;
        feesTypeList[index].name =
            feesTypeResponseModel.data!.feesTypes!.first.name;
        feesTypeList[index].description =
            feesTypeResponseModel.data!.feesTypes!.first.description;

        titleTextController.clear();
        descriptionTextController.clear();
        createUpdateLoader.value = false;
        feesTypeList.refresh();
        Get.back();
      } else {
        createUpdateLoader.value = false;
        showBasicFailedSnackBar(
            message: feesTypeResponseModel.message ?? 'Something went wrong');
      }
    } catch (e, t) {
      createUpdateLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      createUpdateLoader.value = false;
    }
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
      Obx(
        () => Container(
          height: Get.height * 0.5,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              color: bottomSheetBackgroundColor),
          child: Column(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
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
                              DuplicateDropdown(
                                dropdownValue: adminFeesGroupController
                                    .feesGroupInitialValue.value,
                                dropdownList:
                                    adminFeesGroupController.feesGroupList,
                                changeDropdownValue: (value) {
                                  FeesGroupData feesGroupData = value;

                                  adminFeesGroupController
                                      .feesGroupInitialValue.value = value;
                                  adminFeesGroupController.groupId.value =
                                      feesGroupData.id!;
                                },
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
                      ),
                      10.verticalSpacing,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30,
                        ),
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
                            createUpdateLoader.value || deleteLoader.value
                                ? const CircularProgressIndicator()
                                : PrimaryButton(
                                    width: Get.width * 0.2,
                                    title: "Save",
                                    textStyle:
                                        AppTextStyle.textStyle12WhiteW500,
                                    onTap: onTapForSave,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      isDismissible: false,
    );
  }

  @override
  void onInit() {
    getFeesListList();
    super.onInit();
  }
}
