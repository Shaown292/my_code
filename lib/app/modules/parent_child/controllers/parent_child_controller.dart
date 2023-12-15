import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/parent/child/parents_child_list_response_model.dart';
import 'package:get/get.dart';

class ParentChildController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  RxBool isLoading = false.obs;

  RxList<ParentChildData> parentChildList = <ParentChildData>[].obs;

  Future<ParentsChildListResponseModel> getParentsChildData({required int parentId}) async {

    try{
      isLoading.value = true;
      parentChildList.clear();


      final response = await BaseClient().getData(url: InfixApi.getParentsChildData(parentId: parentId), header: GlobalVariable.header);

      ParentsChildListResponseModel parentsChildListResponseModel = ParentsChildListResponseModel.fromJson(response);

      if(parentsChildListResponseModel.success == true){
        isLoading.value = false;
        for(var element in parentsChildListResponseModel.data!){
          parentChildList.add(element);
        }
      } else{
        isLoading.value = false;
        showBasicFailedSnackBar(message: parentsChildListResponseModel.message ?? AppText.somethingWentWrong,);
      }

    }catch(e, t){
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    }finally{
      isLoading.value = false;
    }

    return ParentsChildListResponseModel();
  }


  @override
  void onInit() {
    if(globalRxVariableController.parentId.value != null){
      getParentsChildData(parentId: globalRxVariableController.parentId.value!);
    }

    super.onInit();
  }


}
