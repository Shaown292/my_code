import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/transport_response_model/transport_response_model.dart';
import '../../../utilities/api_urls.dart';

class TransportController extends GetxController {

  LoadingController loadingController = Get.find();

  List<TransportDataList> transportDataList = [];

  Future<TransportResponseModel?> getAllTransportList({required int studentId}) async {

    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentTransport(studentId: studentId),
        header: GlobalVariableController.header,
      );


      TransportResponseModel transportResponseModel = TransportResponseModel.fromJson(response);
      if(transportResponseModel.success == true){
        loadingController.isLoading = false;
        if(transportResponseModel.data!.isNotEmpty){
          for(int i = 0; i < transportResponseModel.data!.length; i++) {
            transportDataList.add(transportResponseModel.data![i]);
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
    return TransportResponseModel();
  }
  @override
  void onInit() {
    getAllTransportList(studentId: GlobalVariableController.studentId!);
    super.onInit();
  }

}
