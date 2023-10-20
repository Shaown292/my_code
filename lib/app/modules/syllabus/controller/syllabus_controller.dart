import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/syllabus/syllabus_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  downloadFile(String fileUrl, String savePath) async {
    print(':::::::::::::::::');
    final response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      final File file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded to: $savePath');
    } else {
      throw Exception('Failed to download file');
    }
  }

}