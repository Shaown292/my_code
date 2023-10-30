import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/exam_dropdown_model/exam_dropdown_response_model.dart';
import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';
import '../../../utilities/api_urls.dart';

class ExaminationController extends GetxController {

  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> examinationTileList = [
    HomeTileModelClass(
        icon: ImagePath.examinationSchedule,
        title: 'Schedule',
        value: 'Schedule'),
    HomeTileModelClass(
        icon: ImagePath.examinationResult, title: 'Result', value: 'Result'),
  ];

  List<ExamDataList> examDropdownList = [];

  void getStudentExamList() async {
    try {
      final response = await BaseClient().getData(
        url: InfixApi.getStudentExamSchedule(GlobalVariableController.roleId!),
        header: GlobalVariableController.header,
      );

      ExamDropdownResponseModel examDropdownResponseModel =
          ExamDropdownResponseModel.fromJson(response);
      if (examDropdownResponseModel.success == true) {
        if (examDropdownResponseModel.data.isNotEmpty) {
          for (int i = 0; i < examDropdownResponseModel.data.length; i++) {
            examDropdownList.add(examDropdownResponseModel.data[i]);
          }
        }
      } else {
        showBasicFailedSnackBar(message: examDropdownResponseModel.message);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  @override
  void onInit() {
    getStudentExamList();
    super.onInit();
  }
}
