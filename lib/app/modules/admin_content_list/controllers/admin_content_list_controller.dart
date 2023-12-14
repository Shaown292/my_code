import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_content_model/admin_content_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminContentListController extends GetxController {
  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();
  RxBool deleteLoader = false.obs;

  RxList<AdminContentData> contentList = <AdminContentData>[].obs;

  Future<AdminContentListResponseModel> getAdminContentList() async {
    try {
      contentList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1 ?  InfixApi.getAdminContentList : InfixApi.getTeacherContentList, header: GlobalVariable.header);

      AdminContentListResponseModel adminContentListResponseModel =
          AdminContentListResponseModel.fromJson(response);

      if (adminContentListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminContentListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < adminContentListResponseModel.data!.length; i++) {
            contentList.add(adminContentListResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminContentListResponseModel.message ??
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

    return AdminContentListResponseModel();
  }

  Future<PostRequestResponseModel> deleteContent(
      {required int contentId, required int index}) async {
    try {
      deleteLoader.value = true;

      final response = await BaseClient().postData(
          url: globalRxVariableController.roleId.value == 1 ? InfixApi.adminContentDelete(contentId: contentId) : InfixApi.teacherContentDelete(contentId: contentId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteLoader.value = false;
        Get.back();
        contentList.removeAt(index);
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? '');
      } else {
        deleteLoader.value = false;
        showBasicFailedSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      deleteLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  void fileDownload({required String url, required String title}) {
    url == ''
        ? showBasicFailedSnackBar(
            message: 'No File Available',
          )
        : FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  void showDialog({required int contentId, required int index}) {
    Get.dialog(
      Obx(
        () => CustomPopupDialogue(
          onYesTap: () {
            deleteContent(contentId: contentId, index: index);
          },
          isLoading: deleteLoader.value,
          subTitle: AppText.deleteDocumentsWarningMsg,
          noText: 'Cancel',
          yesText: 'Delete',
        ),
      ),
    );
  }

  @override
  void onInit() {
    getAdminContentList();
    super.onInit();
  }
}
