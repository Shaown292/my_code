import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_transport_model/admin_transport_route_response_model.dart';
import 'package:get/get.dart';

class AdminRouteController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool saveLoader = false.obs;

  TabController? tabController;

  TextEditingController routeTitleTextController = TextEditingController();
  TextEditingController routeFareTextController = TextEditingController();

  List<String> tabs = <String>[
    'Add New',
    'Route List',
  ];

  RxList<AdminTransportRouteData> adminTransportRouteList =
      <AdminTransportRouteData>[].obs;

  Future<AdminTransportRouteResponseModel> getAdminTransportRouteList() async {
    try {
      adminTransportRouteList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminTransportRouteList,
          header: GlobalVariable.header);

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);

      if (adminTransportRouteResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminTransportRouteResponseModel.data!.length;
              i++) {
            adminTransportRouteList
                .add(adminTransportRouteResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminTransportRouteResponseModel.message ??
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

    return AdminTransportRouteResponseModel();
  }

  Future<AdminTransportRouteResponseModel> addTransportRoute() async {
    try {
      saveLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.postAdminTransportRoute,
        header: GlobalVariable.header,
        payload: {
          "title": routeTitleTextController.text,
          "far": routeFareTextController.toString(),
        },
      );

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);
      if (adminTransportRouteResponseModel.success == true) {
        saveLoader.value = false;

        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          adminTransportRouteList.add(
            AdminTransportRouteData(
              id: adminTransportRouteResponseModel.data![0].id,
              title: adminTransportRouteResponseModel.data![0].title,
              far: adminTransportRouteResponseModel.data![0].far,
            ),
          );
        }

        routeTitleTextController.clear();
        routeFareTextController.clear();
        showBasicSuccessSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong.');
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong.');
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }

    return AdminTransportRouteResponseModel();
  }

  bool validation() {
    if (routeTitleTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Title.');
      return false;
    }

    if (routeFareTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Fare.');
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    getAdminTransportRouteList();
    super.onInit();
  }
}
