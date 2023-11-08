import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/syllabus/syllabus_response_model.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class SyllabusController extends GetxController {
  @override
  void onInit() {
    getSyllabusList();
    super.onInit();
  }

  LoadingController loadingController = Get.find();
  List<SyllabusList> syllabusList = [];

  void getSyllabusList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getSyllabusList(
          GlobalVariableController.studentRecordId!,
        ),
        header: GlobalVariableController.header,
      );

      SyllabusResponseModel syllabusResponseModel =
          SyllabusResponseModel.fromJson(response);
      if (syllabusResponseModel.success == true) {
        loadingController.isLoading = false;
        if (syllabusResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < syllabusResponseModel.data!.length; i++) {
            syllabusList.add(syllabusResponseModel.data![i]);
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

  Future<void> downloadFiles({
    required String url,
    required String title,
  }) async {
    Dio dio = Dio();

    String dirLocation = "";
    double received;
    var progress = ''.obs;
    if (Platform.isAndroid) {
      dirLocation = "/sdcard/download/";
    } else {
      dirLocation = (await getApplicationSupportDirectory()).path;
    }

    showBasicSuccessSnackBar(message: 'Location:::: $dirLocation');

    try {
      FileUtils.mkdir([dirLocation]);
      showBasicSuccessSnackBar(message: 'Downloading...');

      await dio.download(
          InfixApi.root + url, dirLocation + AppConfig.getExtension(url),
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (receivedBytes, totalBytes) async {
        received = ((receivedBytes / totalBytes) * 100);
        progress.value =
            "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";

        if (received == 100.0) {
          if (url.contains('.pdf')) {
            showBasicSuccessSnackBar(
                message:
                    "Download Completed. File is also available in your download folder.");
          } else {
            var file =
                await DefaultCacheManager().getSingleFile(InfixApi.root + url);
            OpenFilex.open(file.path);

            showBasicSuccessSnackBar(
                message:
                    "Download Completed. File is also available in your download folder.");
          }
        }
      });
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }
}
