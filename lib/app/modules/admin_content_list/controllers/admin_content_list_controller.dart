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
import 'package:get/get.dart';

class AdminContentListController extends GetxController {
  LoadingController loadingController = Get.find();

  RxList<AdminContentData> contentList = <AdminContentData>[].obs;

  Future<AdminContentListResponseModel> getAdminContentList() async {
    try {
      contentList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminContentList, header: GlobalVariable.header);

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

  void deleteContent(){
    Get.back();
  }

  void fileDownload(){
    debugPrint('file downloaded');
    //FileDownloadUtils().downloadFiles(url: 'url', title: 'title');
  }

  void showDialog({required int id, required int index}) {
    Get.dialog(
      CustomPopupDialogue(
        onYesTap: deleteContent,
          subTitle: AppText.deleteDocumentsWarningMsg,
          noText: 'Cancel',
          yesText: 'Delete'),
    );
  }

  @override
  void onInit() {
    getAdminContentList();
    super.onInit();
  }
}
