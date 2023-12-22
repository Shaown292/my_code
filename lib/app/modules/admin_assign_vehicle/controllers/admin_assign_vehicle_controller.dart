import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_assign_vehicle_and_route_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminAssignVehicleController extends GetxController {

  LoadingController loadingController = Get.find();
  RxBool dropdownLoader = false.obs;


  Rx<AdminVehicleAssignRoutes> assignRouteInitialValue =
      AdminVehicleAssignRoutes(id: -1, name: "Assign Route").obs;
  RxList<AdminVehicleAssignRoutes> assignRouteList = <AdminVehicleAssignRoutes>[].obs;

  Rx<AdminVehicleAssignVehicles> assignVehicleInitialValue =
      AdminVehicleAssignVehicles(id: -1, name: "Assign Vehicle").obs;
  RxList<AdminVehicleAssignVehicles> assignVehicleList = <AdminVehicleAssignVehicles>[].obs;

  RxInt routeId = 0.obs;
  RxInt vehicleId = 0.obs;


  Future<AdminAssignVehicleAndRouteResponseModel> getAdminVehicleAssignRouteAndVehicleList() async {
    try {
      assignRouteList.clear();
      assignVehicleList.clear();
      dropdownLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminVehicleAssignRouteAndVehicleList, header: GlobalVariable.header);

      AdminAssignVehicleAndRouteResponseModel adminAssignVehicleAndRouteResponseModel =
      AdminAssignVehicleAndRouteResponseModel.fromJson(response);

      if (adminAssignVehicleAndRouteResponseModel.success == true) {
        dropdownLoader.value = false;
        if (adminAssignVehicleAndRouteResponseModel.data!.routes!.isNotEmpty) {
          for (int i = 0;
          i < adminAssignVehicleAndRouteResponseModel.data!.routes!.length;
          i++) {
            assignRouteList
                .add(adminAssignVehicleAndRouteResponseModel.data!.routes![i]);
          }
          assignRouteInitialValue.value = assignRouteList[0];
          routeId.value = assignRouteList[0].id!;
        }


        if (adminAssignVehicleAndRouteResponseModel.data!.vehicles!.isNotEmpty) {
          for (int i = 0;
          i < adminAssignVehicleAndRouteResponseModel.data!.vehicles!.length;
          i++) {
            assignVehicleList
                .add(adminAssignVehicleAndRouteResponseModel.data!.vehicles![i]);
          }
          assignVehicleInitialValue.value = assignVehicleList[0];
          vehicleId.value = assignVehicleList[0].id!;
        }

      } else {
        dropdownLoader.value = false;
        showBasicFailedSnackBar(
          message: adminAssignVehicleAndRouteResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      dropdownLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      dropdownLoader.value = false;
    }

    return AdminAssignVehicleAndRouteResponseModel();
  }

  Future<void> addAssignVehicleToRoute({required int routeId, required int vehicleId}) async {

    try{

      loadingController.isLoading = true;

      final response = await BaseClient().postData(url: InfixApi.postAdminVehicleAssignRouteAndVehicle, header: GlobalVariable.header, payload: {
        'route': routeId,
        'vehicles': vehicleId,
      });

      PostRequestResponseModel postRequestResponseModel = PostRequestResponseModel.fromJson(response);

      if(postRequestResponseModel.success == true){
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: postRequestResponseModel.message ?? '');
      } else{
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: postRequestResponseModel.message ?? AppText.somethingWentWrong,);
      }

    } catch(e, t){
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }



  }


@override
  void onInit() {
  getAdminVehicleAssignRouteAndVehicleList();
    super.onInit();
  }

}
