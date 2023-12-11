import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/file_downloader/file_download_utils.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

class TeContentListController extends GetxController {

  LoadingController loadingController = Get.find();
  RxBool deleteLoader = false.obs;




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

          },
          isLoading: deleteLoader.value,
          subTitle: AppText.deleteDocumentsWarningMsg,
          noText: 'Cancel',
          yesText: 'Delete',
        ),
      ),
    );
  }
}
