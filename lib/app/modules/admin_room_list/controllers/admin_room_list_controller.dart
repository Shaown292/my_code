import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/dormitory_model/dormitory_room_list_response_model.dart';
import 'package:get/get.dart';

class AdminRoomListController extends GetxController {

  LoadingController loadingController = Get.find();

  List<DormitoryRoomListData> dormitoryRoomList = [];

  Future<DormitoryRoomListResponseModel> getDormitoryRoomList() async {

    try{
      dormitoryRoomList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(url: InfixApi.dormitoryRoomList, header: GlobalVariable.header,);
      DormitoryRoomListResponseModel dormitoryRoomListResponseModel = DormitoryRoomListResponseModel.fromJson(response);

      if(dormitoryRoomListResponseModel.success == true){
        if(dormitoryRoomListResponseModel.data!.isNotEmpty){
          for(int i = 0; i < dormitoryRoomListResponseModel.data!.length; i++){
            dormitoryRoomList.add(dormitoryRoomListResponseModel.data![i]);
          }
        }
      }

    } catch(e, t){loadingController.isLoading = false; debugPrint('$e'); debugPrint('$t');} finally{
      loadingController.isLoading = false;
    }

    return DormitoryRoomListResponseModel();
  }

  @override
  void onInit() {
    getDormitoryRoomList();
    super.onInit();
  }

}
