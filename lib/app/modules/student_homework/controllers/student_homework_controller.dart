import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_homework_response_model/student_homework_model.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class StudentHomeworkController extends GetxController {
  @override
  void onInit() {
    getHomeWorkList();
    super.onInit();
  }

  List<HomeworkLists> studentHomeworkList = [];
  LoadingController loadingController = Get.find();

  void getHomeWorkList() async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
          url: InfixApi.getStudentHomeWork(GlobalVariable.studentRecordId!),
          header: GlobalVariable.header);

      StudentHomeWorkModel studentHomeWorkModel =
          StudentHomeWorkModel.fromJson(response);

      if (studentHomeWorkModel.success == true) {
        loadingController.isLoading = false;
        if (studentHomeWorkModel.data!.homeworkLists!.isNotEmpty) {
          for (int i = 0;
              i < studentHomeWorkModel.data!.homeworkLists!.length;
              i++) {
            studentHomeworkList
                .add(studentHomeWorkModel.data!.homeworkLists![i]);
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

  void showHomeworkDetailsBottomSheet({required int index, Color? color}) {
    Get.bottomSheet(
      Container(
        color: color,
        height: Get.height * 0.5,
        child: studentHomeworkList.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpacing,
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          studentHomeworkList[index].subject ?? "",
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                      BottomSheetTile(
                        title: "Created at",
                        value: studentHomeworkList[index].createdAt,
                        color: AppColors.homeworkWidgetColor,
                      ),
                      BottomSheetTile(
                        title: "Submission",
                        value: studentHomeworkList[index].submissionDate,
                        color: Colors.white,
                      ),
                      BottomSheetTile(
                        title: "Evaluation",
                        value: studentHomeworkList[index].evaluationDate,
                        color: AppColors.homeworkWidgetColor,
                      ),
                      BottomSheetTile(
                        title: "Obtained Marks",
                        value: studentHomeworkList[index].marks.toString(),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          text: "Download",
                          width: 100,
                          borderRadius: 10,
                          onTap: () {},
                        ),
                        PrimaryButton(
                          text: "Upload",
                          width: 60,
                          borderRadius: 10,
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              )
            : const Center(
                child: Text(
                  "No Details Available",
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
              ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }
}
