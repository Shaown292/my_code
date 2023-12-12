import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/app_config.dart';
import '../message/snack_bars.dart';
import '../widgets/download_viewer/download_viewer_screen.dart';

class FileDownloadUtils {
  Future<void> downloadFiles({
    required String url,
    required String title,
  }) async {
    debugPrint('Download Url ::: $url');

    Dio dio = Dio();

    double received = 0;
    var progress = ''.obs;

    String directoryLocation = "";
    if (Platform.isAndroid) {
      directoryLocation = "/sdcard/download/";
    } else {
      directoryLocation = (await getApplicationSupportDirectory()).path;
    }
    showBasicSuccessSnackBar(message: directoryLocation);

    try {
      FileUtils.mkdir([directoryLocation]);
      showBasicSuccessSnackBar(message: "Downloading...");

      await dio.download(
        url,
        directoryLocation + AppConfig.getExtension(url),
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
              Get.to(()=> DownloadViewer(filePath: url));
            } else {
              var file = await DefaultCacheManager().getSingleFile(url);
              OpenFilex.open(file.path);
              showBasicSuccessSnackBar(
                  message:
                      "Download Completed. File is also available in your download folder.");
            }
          }
        },
      );
    } catch (e, t) {
      Get.snackbar('Error!', 'No file found on server',
          colorText: Colors.white,
          backgroundColor: AppColors.activeStatusRedColor,
          snackPosition: SnackPosition.TOP,
          barBlur: 0.5);
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
    progress.value =
        "Download Completed.Go to the download folder to find the file";
  }
}
