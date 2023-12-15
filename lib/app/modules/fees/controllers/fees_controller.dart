import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_fees_response_model/student_fees_response_model.dart';
import 'package:get/get.dart';

class FeesController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  // LoadingController loadingController = Get.find();
  RxBool feesLoader = false.obs;
  HomeController homeController = Get.find();

  RxInt recordId = 0.obs;
  final selectIndex = RxInt(0);

  List<FeesInvoice> feesInvoiceList = [];

  Future<StudentFeesInvoiceResponseModel?> getAllFeesList(
      {required int studentId, required int recordId}) async {
    feesInvoiceList.clear();
    try {
      feesLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentFeesList(
            studentId: studentId, recordId: recordId),
        header: GlobalVariable.header,
      );

      StudentFeesInvoiceResponseModel studentFeesInvoiceResponseModel =
      StudentFeesInvoiceResponseModel.fromJson(response);
      if (studentFeesInvoiceResponseModel.success == true) {
        feesLoader.value = false;
        if (studentFeesInvoiceResponseModel.data!.feesInvoice!.isNotEmpty) {
          for (int i = 0;
          i < studentFeesInvoiceResponseModel.data!.feesInvoice!.length;
          i++) {
            feesInvoiceList
                .add(studentFeesInvoiceResponseModel.data!.feesInvoice![i]);
          }
        }
      } else{
        feesLoader.value = false;
        showBasicFailedSnackBar(message: studentFeesInvoiceResponseModel.message ?? AppText.somethingWentWrong,);
      }
    } catch (e, t) {
      feesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      feesLoader.value = false;
    }
    return StudentFeesInvoiceResponseModel();
  }

  void showFeesDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text(
                "Reason:",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Apply Date",
              ),
              const BottomSheetTile(
                title: "Leave From",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Leave To",
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {

    if(homeController.studentRecordList.isNotEmpty){
      getAllFeesList(
        studentId:
        globalRxVariableController.studentId.value!,
        recordId: globalRxVariableController.studentRecordId.value!,
      );
    }

    super.onInit();
  }
}
