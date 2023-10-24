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
import 'package:permission_handler/permission_handler.dart';

class SyllabusController extends GetxController {

  @override
  void onInit() {
    getSyllabusList();
    // if (Platform.isAndroid) {
    //   platform = TargetPlatform.android;
    // } else {
    //   platform = TargetPlatform.iOS;
    // }
    super.onInit();
  }

  // late String localPath;
  // late bool permissionReady;
  // late TargetPlatform? platform;
  //
  // Future<bool> checkPermission() async {
  //   if (platform == TargetPlatform.android) {
  //     final status = await Permission.storage.status;
  //     print('Status :::::::: $status');
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.storage.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // Future<void> prepareSaveDir() async {
  //   localPath = (await _findLocalPath())!;
  //
  //   print(localPath);
  //   final savedDir = Directory(localPath);
  //   bool hasExisted = await savedDir.exists();
  //   if (!hasExisted) {
  //     savedDir.create();
  //   }
  // }
  //
  // Future<String?> _findLocalPath() async {
  //   if (platform == TargetPlatform.android) {
  //     return "/sdcard/download/";
  //   } else {
  //     var directory = await getApplicationDocumentsDirectory();
  //     return '${directory.path}${Platform.pathSeparator}Download';
  //   }
  // }
  //
  // fileDownloader(String url) async {
  //   print('object""""""""""');
  //   await prepareSaveDir();
  //   print("Downloading");
  //   try {
  //     await Dio().download(url,
  //         "$localPath${AppConfig.getExtension(url)}");
  //     print("Download Completed.");
  //
  //     var file = await DefaultCacheManager().getSingleFile(InfixApi.root + url);
  //     OpenFilex.open(file.path);
  //
  //   } catch (e) {
  //     print("Download Failed.\n\n$e");
  //   }
  // }
  // dirloc + AppFunction.getExtention(url)
  LoadingController loadingController = Get.find();
  List<SyllabusList> syllabusList = [];

  var progress = "Download".obs;
  // ignore: prefer_typing_uninitialized_variables
  var received;

  // File? downloadedFile;
  // RxString downloadMessage = "Press download".obs;

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
      String url) async {
    Dio dio = Dio();

    String directoryLocation = "";
    if (Platform.isAndroid) {
      directoryLocation = "/sdcard/download/";
      print('Location ::::: $directoryLocation');
    } else {
      directoryLocation = (await getApplicationSupportDirectory()).path;
      print('Location ::::: $directoryLocation');
    }
    showBasicSuccessSnackBar(message: directoryLocation);

    try {
      FileUtils.mkdir([directoryLocation]);
      print('nf,mng,mfdg,d${FileUtils.mkdir([directoryLocation])}');

      await dio.download(
          InfixApi.root + url, directoryLocation + AppConfig.getExtension(url),
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (receivedBytes, totalBytes) async {
            received = ((receivedBytes / totalBytes) * 100);

            print(':::::::::::::::::');

              progress.value =
                  "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";

            if (received == 100.0) {
              print(':::::::::::::::::1');
              if (url.contains('.pdf')) {

                showBasicSuccessSnackBar(message: "Download Completed. File is also available in your download folder.");
                // Navigator.push(
                //     context,
                //     ScaleRoute(
                //         page: DownloadViewer(
                //             title: title, filePath: InfixApi.root + url)));
              } else {
                var file = await DefaultCacheManager().getSingleFile(InfixApi.root + url);
                OpenFilex.open(file.path);
                print('File ::::::::: $file');

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

  // Future<void> downloadFile(
  //     String url, String title) async {
  //   Dio dio = Dio();
  //
  //   print(url);
  //   String dirloc = "";
  //   double received;
  //   var progress = ''.obs;
  //   if (Platform.isAndroid) {
  //     dirloc = "/sdcard/download/";
  //   } else {
  //     dirloc = (await getApplicationSupportDirectory()).path;
  //   }
  //
  //   showBasicSuccessSnackBar(message: 'Location:::: $dirloc');
  //
  //   try {
  //     FileUtils.mkdir([dirloc]);
  //     showBasicSuccessSnackBar(message: 'Downloading...');
  //
  //     await dio.download(
  //         InfixApi.root + url, dirloc + AppConfig.getExtension(url),
  //         options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
  //         onReceiveProgress: (receivedBytes, totalBytes) async {
  //           received = ((receivedBytes / totalBytes) * 100);
  //           progress.value = "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
  //           print(':::::::::::::: $received');
  //
  //           if (received == 100.0) {
  //             print('100:::::::::::::');
  //             print('${dirloc + AppConfig.getExtension(url)}:::::::::::::');
  //             if (url.contains('.pdf')) {
  //               showBasicSuccessSnackBar(message: "Download Completed. File is also available in your download folder.");
  //               // Navigator.push(
  //               //     context,
  //               //     ScaleRoute(
  //               //         page: DownloadViewer(
  //               //             title: title, filePath: InfixApi.root + url)));
  //             } else {
  //               print('object:::::::::::::::::::::');
  //               var file =
  //               await DefaultCacheManager().getSingleFile(InfixApi.root + url);
  //               OpenFilex.open(file.path);
  //
  //               showBasicSuccessSnackBar(message: "Download Completed. File is also available in your download folder.");
  //             }
  //           }
  //         });
  //   } catch (e, t) {
  //     debugPrint(e.toString());
  //     debugPrint(t.toString());
  //   }
  //   // progress = "Download Completed.Go to the download folder to find the file";
  // }

  // Future downloadFile({
  //   required String url,
  //   required String filename,
  // }) async {
  //
  //
  //
  //   try {
  //     HttpClient client = HttpClient();
  //     List<int> downloadData = [];
  //
  //     Directory downloadDirectory;
  //
  //     if (Platform.isIOS) {
  //       downloadDirectory = await getApplicationDocumentsDirectory();
  //     } else {
  //       downloadDirectory = Directory('/storage/emulated/0/Download');
  //       if (!await downloadDirectory.exists()) downloadDirectory = (await getExternalStorageDirectory())!;
  //     }
  //
  //     String filePathName = "${downloadDirectory.path}/$filename";
  //     File savedFile = File(filePathName);
  //     bool fileExists = await savedFile.exists();
  //
  //     if (fileExists) {
  //       showBasicSuccessSnackBar(message: "File already downloaded");
  //     } else {
  //       client.getUrl(Uri.parse(url)).then(
  //             (HttpClientRequest request) {
  //
  //             downloadMessage.value = "Loading";
  //             print(downloadMessage);
  //
  //           return request.close();
  //         },
  //       ).then(
  //             (HttpClientResponse response) {
  //           response.listen((d) => downloadData.addAll(d), onDone: () {
  //             savedFile.writeAsBytes(downloadData);
  //             print(downloadMessage);
  //               downloadedFile = savedFile;
  //             print(downloadedFile);
  //
  //           });
  //         },
  //       );
  //     }
  //   } catch (error) {
  //
  //       downloadMessage.value = "Some error occurred -> $error";
  //
  //   }
  // }


}

