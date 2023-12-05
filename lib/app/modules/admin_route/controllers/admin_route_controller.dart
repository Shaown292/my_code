import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
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
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_transport_route_response_model.dart';
import 'package:get/get.dart';

class AdminRouteController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool saveLoader = false.obs;
  RxBool createUpdateLoader = false.obs;

  TabController? tabController;

  TextEditingController routeTitleTextController = TextEditingController();
  TextEditingController routeFareTextController = TextEditingController();

  List<String> tabs = <String>[
    'Add New',
    'Route List',
  ];

  RxList<AdminTransportRouteData> adminTransportRouteList =
      <AdminTransportRouteData>[].obs;

  Future<AdminTransportRouteResponseModel> getAdminTransportRouteList() async {
    try {
      adminTransportRouteList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminTransportRouteList,
          header: GlobalVariable.header);

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);

      if (adminTransportRouteResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminTransportRouteResponseModel.data!.length;
              i++) {
            adminTransportRouteList
                .add(adminTransportRouteResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminTransportRouteResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminTransportRouteResponseModel();
  }

  Future<AdminTransportRouteResponseModel> addTransportRoute() async {
    try {
      saveLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.postAdminTransportRoute,
        header: GlobalVariable.header,
        payload: {
          "title": routeTitleTextController.text,
          "far": routeFareTextController.toString(),
        },
      );

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);
      if (adminTransportRouteResponseModel.success == true) {
        saveLoader.value = false;

        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          adminTransportRouteList.add(
            AdminTransportRouteData(
              id: adminTransportRouteResponseModel.data![0].id,
              title: adminTransportRouteResponseModel.data![0].title,
              far: adminTransportRouteResponseModel.data![0].far,
            ),
          );
        }

        routeTitleTextController.clear();
        routeFareTextController.clear();
        showBasicSuccessSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong.');
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong.');
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }

    return AdminTransportRouteResponseModel();
  }

  bool validation() {
    if (routeTitleTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Title.');
      return false;
    }

    if (routeFareTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Fare.');
      return false;
    }

    return true;
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
                          routeTitleTextController.clear();
                          routeFareTextController.clear();
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
              Obx(
                    () => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
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
                      createUpdateLoader.value
                          ? const CircularProgressIndicator()
                          : PrimaryButton(
                        width: Get.width * 0.2,
                        title: "Save",
                        textStyle: AppTextStyle.textStyle12WhiteW500,
                        onTap: onTapForSave,
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
    );
  }

  @override
  void onInit() {
    getAdminTransportRouteList();
    super.onInit();
  }
}
