import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_vehicle_list_response_model.dart';
import 'package:get/get.dart';

class AdminVehicleController extends GetxController {

  LoadingController loadingController = Get.find();

  TabController? tabController;

  TextEditingController vehicleNoTextController = TextEditingController();
  TextEditingController vehicleModelTextController = TextEditingController();
  TextEditingController madeYearTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  RxList<AdminVehicleData> adminVehicleList =
      <AdminVehicleData>[].obs;

  RxString initialValue = "Rohit Sharma".obs;
  RxList <String> list = [
    "Rohit Sharma",
    "Virat Kohli",
    "Subhman Gill"
  ].obs;

  List<String> tabs = <String>[
    'Add Vehicle',
    'Vehicle List',
  ];





  Future<AdminVehicleListResponseModel> getAdminVehicleList() async {
    try {
      adminVehicleList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminVehicleList, header: GlobalVariable.header);

      AdminVehicleListResponseModel adminVehicleListResponseModel =
      AdminVehicleListResponseModel.fromJson(response);

      if (adminVehicleListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminVehicleListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < adminVehicleListResponseModel.data!.length; i++) {
            adminVehicleList.add(adminVehicleListResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminVehicleListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminVehicleListResponseModel();
  }


  @override
  void onInit() {
    getAdminVehicleList();
    super.onInit();
  }


}
