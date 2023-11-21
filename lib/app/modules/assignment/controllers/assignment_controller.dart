import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_assignment_response_model/student_assignment_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';

class AssignmentController extends GetxController {

  LoadingController loadingController = Get.find();
  List<StudentAssignmentData> studentAssignmentList = [];

  void getStudentAssignmentList() async {
    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAssignmentList(
          GlobalVariable.studentRecordId!,
        ),
        header: GlobalVariable.header,
      );

      StudentAssignmentResponseModel studentAssignmentResponseModel = StudentAssignmentResponseModel.fromJson(response);
      if(studentAssignmentResponseModel.success == true){
        loadingController.isLoading = false;
        if(studentAssignmentResponseModel.data!.isNotEmpty){
          for(int i = 0; i < studentAssignmentResponseModel.data!.length; i++) {
            studentAssignmentList.add(studentAssignmentResponseModel.data![i]);
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

  void showStudentAssignmentDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      SizedBox(
        height: Get.height*0.3,
        child: Column (
          children: [
            Text(studentAssignmentList[index].contentTitle ?? ''),
            Text(studentAssignmentList[index].availableFor ?? ''),
            Text(studentAssignmentList[index].uploadDate ?? ''),

          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    getStudentAssignmentList();
    super.onInit();
  }

}
