import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/fees_response_model/fees_response_model.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class FeesController extends GetxController {

  LoadingController loadingController = Get.find();

  List<InvoiceDetails> invoiceDetails = [];


  Future<FeesResponseModel?> getAllFeesList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentFeesDetails(),
        header: GlobalVariableController.header,
      );

     FeesResponseModel feesResponseModel = FeesResponseModel.fromJson(response);
      if (feesResponseModel.success == true) {
        loadingController.isLoading = false;
        if (feesResponseModel.data!.invoiceDetails!.isNotEmpty) {
          for (int i = 0;
          i < feesResponseModel.data!.invoiceDetails!.length;
          i++) {
            invoiceDetails.add(feesResponseModel.data!.invoiceDetails![i]);
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
    return FeesResponseModel();
  }

  void showFeesDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Text("Reason:" ?? "", style:  AppTextStyle.fontSize14BlackW500,),
              20.verticalSpacing,
              const BottomSheetTile(
                title: "Leave Type",
                value: "",
                color: AppColors.homeworkWidgetColor ,
              ),
              const BottomSheetTile(
                title: "Apply Date",
              ),
              const BottomSheetTile(
                title: "Leave From",
                color: AppColors.homeworkWidgetColor ,
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
    getAllFeesList();
    super.onInit();
  }

}
