import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/syllabus/syllabus_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

      SyllabusResponseModel syllabusResponseModel = SyllabusResponseModel.fromJson(response);
      if(syllabusResponseModel.success == true){
        loadingController.isLoading = false;
        if(syllabusResponseModel.data!.isNotEmpty){
          for(int i = 0; i < syllabusResponseModel.data!.length; i++) {
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

  Future<void> downloadFile(
      String url, String title) async {
    Dio dio = Dio();

    print(url);
    String dirloc = "";
    double received;
    var progress = ''.obs;
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationSupportDirectory()).path;
    }

    showBasicSuccessSnackBar(message: dirloc);

    try {
      FileUtils.mkdir([dirloc]);
      showBasicSuccessSnackBar(message: 'Downloading...');

      await dio.download(
          InfixApi.root + url, dirloc + AppConfig.getExtension(url),
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (receivedBytes, totalBytes) async {
            received = ((receivedBytes / totalBytes) * 100);
            progress.value = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";

            if (received == 100.0) {
              if (url.contains('.pdf')) {
                showBasicSuccessSnackBar(message: "Download Completed. File is also available in your download folder.");
                // Navigator.push(
                //     context,
                //     ScaleRoute(
                //         page: DownloadViewer(
                //             title: title, filePath: InfixApi.root + url)));
              } else {
                print('object:::::::::::::::::::::');
                var file =
                await DefaultCacheManager().getSingleFile(InfixApi.root + url);
                OpenFilex.open(file.path);

                showBasicSuccessSnackBar(message: "Download Completed. File is also available in your download folder.");
              }
            }
          });
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
    // progress = "Download Completed.Go to the download folder to find the file";
  }



}