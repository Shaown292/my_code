import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_vehicle_driver_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_vehicle_list_response_model.dart';
import 'package:get/get.dart';

class AdminVehicleController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool saveLoader = false.obs;
  RxBool dropdownLoader = false.obs;

  TabController? tabController;

  TextEditingController vehicleNoTextController = TextEditingController();
  TextEditingController vehicleModelTextController = TextEditingController();
  TextEditingController madeYearTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  RxList<AdminVehicleData> adminVehicleList = <AdminVehicleData>[].obs;

  RxList<AdminVehicleDriverData> adminVehicleDriverList =
      <AdminVehicleDriverData>[].obs;
  Rx<AdminVehicleDriverData> initialValue =
      AdminVehicleDriverData(id: -1, name: "full_name").obs;
  final driverId = Rxn<int>();

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

  Future<AdminVehicleDriverResponseModel> getAdminVehicleDriverList() async {
    try {
      adminVehicleList.clear();
      dropdownLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminDriverList, header: GlobalVariable.header);

      AdminVehicleDriverResponseModel adminVehicleDriverResponseModel =
          AdminVehicleDriverResponseModel.fromJson(response);

      if (adminVehicleDriverResponseModel.success == true) {
        dropdownLoader.value = false;
        if (adminVehicleDriverResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminVehicleDriverResponseModel.data!.length;
              i++) {
            adminVehicleDriverList
                .add(adminVehicleDriverResponseModel.data![i]);
          }
          initialValue.value = adminVehicleDriverList[0];
        }
      } else {
        dropdownLoader.value = false;
        showBasicFailedSnackBar(
          message: adminVehicleDriverResponseModel.message ??
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

    return AdminVehicleDriverResponseModel();
  }

  Future<AdminVehicleListResponseModel> addAdminVehicle() async {
    try {
      saveLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.adminAddVehicle,
          header: GlobalVariable.header,
          payload: {
            'vehicle_number': vehicleNoTextController.text,
            'vehicle_model': vehicleModelTextController.text,
            'year_made': madeYearTextController.text,
            'driver_id': driverId.value,
            'note': noteTextController.text,
          });

      AdminVehicleListResponseModel adminVehicleListResponseModel =
          AdminVehicleListResponseModel.fromJson(response);

      if (adminVehicleListResponseModel.success == true) {
        saveLoader.value = false;
        // adminVehicleList.add(AdminVehicleData(
        //   id: adminVehicleListResponseModel.data!.first.id,
        //   vehicleModel: adminVehicleListResponseModel.data!.first.vehicleModel,
        //   vehicleNo: adminVehicleListResponseModel.data!.first.vehicleNo,
        //   madeYear: int.tryParse(
        //       adminVehicleListResponseModel.data!.first.vehicleNo ?? ''),
        //   note: adminVehicleListResponseModel.data!.first.note,
        // ));

        adminVehicleList.add(adminVehicleListResponseModel.data!.first);

        adminVehicleList.refresh();
        vehicleNoTextController.clear();
        vehicleModelTextController.clear();
        madeYearTextController.clear();
        noteTextController.clear();
        driverId.value = null;
        showBasicSuccessSnackBar(
            message: adminVehicleListResponseModel.message ?? '');
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
          message: adminVehicleListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }

    return AdminVehicleListResponseModel();
  }

  bool validation() {
    if (vehicleNoTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'The vehicle number field is required.');
      return false;
    } else if (vehicleModelTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'The vehicle model field is required.');
      return false;
    } else if (driverId.value == null) {
      showBasicFailedSnackBar(message: 'The driver id field is required.');
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    getAdminVehicleList();
    getAdminVehicleDriverList();
    super.onInit();
  }
}
