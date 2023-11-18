import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_others_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_parents_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_personal_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_transport_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/students_document_response_model/students_document_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/profile_edit_model/profile_data_controller.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ProfileController extends GetxController {
  PageController profilePageController = PageController();
  ProfileDataController profileDataController =
      Get.put(ProfileDataController());
  LoadingController loadingController = Get.find();
  RxList<ProfileDocuments> documentsDataList = <ProfileDocuments>[].obs;

  Rx<File> file = File('').obs;

  TextEditingController titleTextController = TextEditingController();

  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  ProfilePersonal? profilePersonal;
  ProfileParents? profileParents;
  ProfileTransport? profileTransport;
  ProfileOthers? profileOthers;

  /// Personal
  void fetchProfilePersonalData() async {
    isLoading.value = true;

    try {
      final res = await BaseClient().getData(
        url: InfixApi.profilePersonal(),
        header: GlobalVariableController.header,
      );

      ProfilePersonalModel profilePersonalModel =
          ProfilePersonalModel.fromJson(res);

      if (profilePersonalModel.success == true) {
        profilePersonal = profilePersonalModel.data?.profilePersonal;
        isLoading.value = false;

        profileDataController.firstName.value =
            profilePersonal?.firstName ?? '';
        profileDataController.lastName.value = profilePersonal?.lastName ?? '';
        profileDataController.email.value = profilePersonal?.email ?? '';
        profileDataController.phoneNumber.value = profilePersonal?.mobile ?? '';
        profileDataController.dateOfBirth.value =
            profilePersonal?.dateOfBirth ?? '';
        profileDataController.presentAddress.value =
            profilePersonal?.currentAddress ?? '';
        profileDataController.profilePhoto.value =
            profilePersonal?.studentPhoto ?? '';
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profilePersonalModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  /// Parents
  void fetchProfileParentsData() async {
    isLoading.value = true;

    try {
      final response = await BaseClient().getData(
        url: InfixApi.profileParents(),
        header: GlobalVariableController.header,
      );

      ProfileParentsModel profileParentsModel =
          ProfileParentsModel.fromJson(response);

      if (profileParentsModel.success == true) {
        profileParents = profileParentsModel.data?.profileParents;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileParentsModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  /// Transport
  void fetchProfileTransportData() async {
    isLoading.value = true;

    try {
      final response = await BaseClient().getData(
        url: InfixApi.profileTransport(),
        header: GlobalVariableController.header,
      );

      ProfileTransportModel profileTransportModel =
          ProfileTransportModel.fromJson(response);

      if (profileTransportModel.success == true) {
        profileTransport = profileTransportModel.data?.profileTransport;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileTransportModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  /// Others
  void fetchProfileOthersData() async {
    isLoading.value = true;

    try {
      final response = await BaseClient().getData(
          url: InfixApi.profileOthers(),
          header: GlobalVariableController.header);

      ProfileOthersModel profileOthersModel =
          ProfileOthersModel.fromJson(response);

      if (profileOthersModel.success == true) {
        profileOthers = profileOthersModel.data?.profileOthers;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileOthersModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  ///Documents Get
  Future<StudentDocumentsResponseModel?> getAllDocumentList() async {
    try {
      loadingController.isLoading = true;
      documentsDataList.clear();

      final response = await BaseClient().getData(
        url: InfixApi.profileDocumentGet(),
        header: GlobalVariableController.header,
      );

      StudentDocumentsResponseModel studentDocumentsResponseModel =
          StudentDocumentsResponseModel.fromJson(response);
      if (studentDocumentsResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentDocumentsResponseModel.data!.profileDocuments!.isNotEmpty) {
          for (int i = 0;
              i < studentDocumentsResponseModel.data!.profileDocuments!.length;
              i++) {
            documentsDataList
                .add(studentDocumentsResponseModel.data!.profileDocuments![i]);
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return StudentDocumentsResponseModel();
  }

  /// Documents bottom sheet
  void showUploadDocumentsBottomSheet(
      {required Function() onTap,
      Function()? onTapForSave,
      Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Obx(() => Container(

          height: Get.height * 0.45,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: bottomSheetBackgroundColor

          ),
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
                      color: AppColors.primaryColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Upload Documents",
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: InkWell(
                          onTap: () => Get.back(),
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
                        controller: titleTextController,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Title",
                        fillColor: Colors.white,

                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        fillColor: Colors.white,
                        hintText:
                            "${file.value.path.isNotEmpty ? file : 'Select File'}",
                        readOnly: true,
                        suffixIcon: InkWell(
                          onTap: onTap,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primaryColor),
                              child: const Center(
                                child: Text(
                                  "BROWSE",
                                  style: AppTextStyle.textStyle12WhiteW400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
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
                        onTap: () => Get.back(),
                      ),
                      isLoading.value == true
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : PrimaryButton(
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
          ))),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  /// Documents file picker
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

  /// Documents Post
  void uploadDocuments() async {
    try {
      isLoading.value = true;
      final request = http.MultipartRequest(
          'POST', Uri.parse(InfixApi.studentUploadDocuments));
      request.headers['Authorization'] = GlobalVariableController.token!;

      if (file.value.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', file.value.path));
      }

      request.fields['student_id'] = '${GlobalVariableController.studentId!}';
      request.fields['title'] = titleTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.back();
        showBasicSuccessSnackBar(message: decodedResponse['message']);

        documentsDataList.add(ProfileDocuments(
            title: decodedResponse['data']['title'],
            file: decodedResponse['data']['file'],
            id: decodedResponse['data']['id']));
        // getAllDocumentList();
        titleTextController.clear();
        file.value = File('');
      } else {
        isLoading.value = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  /// Documents Delete
  Future<void> deleteDocument(
      {required int documentId, required int index}) async {
    try {
      var headers = GlobalVariableController.header;
      var request = http.MultipartRequest('GET',
          Uri.parse(InfixApi.profileDocumentDelete(documentId: documentId)));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        Get.back();
        documentsDataList.removeAt(index);
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  @override
  void onInit() {
    fetchProfilePersonalData();
    fetchProfileParentsData();
    fetchProfileTransportData();
    fetchProfileOthersData();
    getAllDocumentList();
    super.onInit();
  }
}
