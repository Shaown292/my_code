import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_homework_response_model/student_homework_model.dart';
import 'package:get/get.dart';

import '../../../../domain/utils/datetime_converter.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';

class StudentHomeworkController extends GetxController {

  @override
  void onInit() {
    getHomeWorkList();
    super.onInit();
  }
  
  List<HomeworkLists> studentHomeworkList = [];
  LoadingController loadingController = Get.find();


  void getHomeWorkList() async {

    try{
      loadingController.isLoading = true;
      final response = await BaseClient().getData(url: InfixApi.getStudentHomeWork(GlobalVariableController.studentRecordId!), header: GlobalVariableController.header);

      StudentHomeWorkModel studentHomeWorkModel = StudentHomeWorkModel.fromJson(response);

      if(studentHomeWorkModel.success == true){
        loadingController.isLoading = false;
        if(studentHomeWorkModel.data!.homeworkLists!.isNotEmpty){
          for(int i = 0; i < studentHomeWorkModel.data!.homeworkLists!.length; i++){
            studentHomeworkList.add(studentHomeWorkModel.data!.homeworkLists![i]);
          }
        }

      }

    } catch(e, t){
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      loadingController.isLoading = false;
    }

  }



    void showHomeworkDetailsBottomSheet({required int index}) {
      Get.bottomSheet(
        SizedBox(
          height: Get.height*0.3,
          child: Column (
            children: [
              Text(studentHomeworkList[index].subject ?? ''),
              Text(studentHomeworkList[index].status ?? ''),
              Text(DateTimeConverter().convertISOToDesiredFormat(studentHomeworkList[index].createdAt ?? '')),
              Text(studentHomeworkList[index].submissionDate ?? ''),
              Text(studentHomeworkList[index].marks.toString()),

            ],
          ),
        ),
        backgroundColor: Colors.white,
        shape: defaultBottomSheetShape(),
      );
    }



}
