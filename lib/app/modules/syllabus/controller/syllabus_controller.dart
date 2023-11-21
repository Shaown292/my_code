import 'package:flutter/foundation.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/syllabus/syllabus_response_model.dart';
import 'package:get/get.dart';

import '../../../utilities/api_urls.dart';

class SyllabusController extends GetxController {
  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      getSyllabusList();
    }

    super.onInit();
  }

  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<SyllabusList> syllabusList = [];

  void getSyllabusList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getSyllabusList(
          GlobalVariable.studentRecordId!,
        ),
        header: GlobalVariable.header,
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
}
