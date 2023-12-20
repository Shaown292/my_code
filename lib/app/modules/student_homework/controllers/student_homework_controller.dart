import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_homework_response_model/student_homework_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import '../../../utilities/widgets/button/primary_button.dart';

class StudentHomeworkController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  List<HomeworkLists> studentHomeworkList = [];
  LoadingController loadingController = Get.find();
  TextEditingController uploadFileTextController = TextEditingController();
  RxBool saveLoader = false.obs;

  RxList<File> pickedFileList = <File>[].obs;

  RxBool isUpload = false.obs;
  RxBool isDismissible = true.obs;

  void getHomeWorkList() async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
          url: InfixApi.getStudentHomeWork(
            globalRxVariableController.studentRecordId.value!,
          ),
          header: GlobalVariable.header);

      StudentHomeWorkModel studentHomeWorkModel =
          StudentHomeWorkModel.fromJson(response);

      if (studentHomeWorkModel.success == true) {
        loadingController.isLoading = false;
        if (studentHomeWorkModel.data!.homeworkLists!.isNotEmpty) {
          for (int i = 0;
              i < studentHomeWorkModel.data!.homeworkLists!.length;
              i++) {
            studentHomeworkList
                .add(studentHomeWorkModel.data!.homeworkLists![i]);
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
  }

  void showHomeworkDetailsBottomSheet({
    required int index,
    Color? color,
    Function()? onDownloadTap,
    Function()? onUploadTap,
    Function()? onTapForSave,
    Function()? onTapBrowse,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          color: color,
          height: Get.height * 0.4,
          child: studentHomeworkList.isNotEmpty
              ? isUpload.value
                  ? Column(
                      children: [
                        Container(
                          height: Get.height * 0.1,
                          width: Get.width,
                          padding: const EdgeInsets.all(20),
                          color: AppColors.primaryColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Upload Homework",
                                style: AppTextStyle.cardTextStyle14WhiteW500,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: InkWell(
                                  onTap: () => isUpload.value = false,
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpacing,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: CustomTextFormField(
                            enableBorderActive: true,
                            focusBorderActive: true,
                            fillColor: Colors.white,
                            hintText: pickedFileList.isNotEmpty
                                ? pickedFileList.first.path
                                : 'Select File',
                            readOnly: true,
                            suffixIcon: InkWell(
                              onTap: onTapBrowse,
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
                        ),
                        Column(
                          children: pickedFileList
                              .map((element) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(element.path.split('/').last),
                                      const Icon(Icons.cancel_outlined),
                                    ],
                                  ))
                              .toList(),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryButton(
                                width: Get.width * 0.15,
                                title: "Cancel",
                                color: Colors.white,
                                textStyle: AppTextStyle.fontSize13BlackW400,
                                borderColor: AppColors.primaryColor,
                                onTap: () {
                                  isUpload.value = false;
                                },
                              ),
                              Obx(
                                () => saveLoader.value == true
                                    ? const CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      )
                                    : PrimaryButton(
                                        width: Get.width * 0.2,
                                        title: "Save",
                                        textStyle:
                                            AppTextStyle.textStyle12WhiteW500,
                                        onTap: onTapForSave,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpacing,
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                studentHomeworkList[index].subject ?? "",
                                style: AppTextStyle.fontSize14BlackW500,
                              ),
                            ),
                            BottomSheetTile(
                              title: "Created at",
                              value: studentHomeworkList[index].createdAt,
                              color: AppColors.homeworkWidgetColor,
                            ),
                            BottomSheetTile(
                              title: "Submission",
                              value: studentHomeworkList[index].submissionDate,
                              color: Colors.white,
                            ),
                            BottomSheetTile(
                              title: "Evaluation",
                              value: studentHomeworkList[index].evaluationDate,
                              color: AppColors.homeworkWidgetColor,
                            ),
                            BottomSheetTile(
                              title: "Obtained Marks",
                              value:
                                  studentHomeworkList[index].marks.toString(),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: onDownloadTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.appButtonColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImagePath.download,
                                        scale: 4,
                                        color: Colors.white,
                                      ),
                                      5.horizontalSpacing,
                                      const Text(
                                        "Download",
                                        style: AppTextStyle
                                            .cardTextStyle14WhiteW500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: onUploadTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.appButtonColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Transform.flip(
                                        flipY: true,
                                        child: Image.asset(
                                          ImagePath.download,
                                          scale: 4,
                                          color: Colors.white,
                                        ),
                                      ),
                                      5.horizontalSpacing,
                                      const Text(
                                        "Upload",
                                        style: AppTextStyle
                                            .cardTextStyle14WhiteW500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
              : const Center(
                  child: Text(
                    "No Details Available",
                    style: AppTextStyle.fontSize16lightBlackW500,
                  ),
                ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  void downloadFile({required String url, required String title}) {
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      pickedFileList.value = result.paths.map((path) => File(path!)).toList();
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }

  void uploadFilesWithId(List<File> files, int id) async {
    try {
      saveLoader.value = true;

      var uri = Uri.parse(InfixApi
          .getStudentHomeWorkUploadFiles); // Replace with your server endpoint
      var request = http.MultipartRequest("POST", uri);

      request.fields['id'] = id.toString();
      request.headers.addAll(GlobalVariable.header);

      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile('files[]', stream, length,
            filename: file.path.split('/').last);

        request.files.add(multipartFile);
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        saveLoader.value = false;
        isUpload.value = false;
        Get.back();
        pickedFileList.clear();
        showBasicSuccessSnackBar(message: decodedResponse["message"]);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse["message"]);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint("$e");
      debugPrint("$t");
    } finally {
      saveLoader.value = false;
    }
  }

  @override
  void onInit() {
    getHomeWorkList();
    super.onInit();
  }
}
