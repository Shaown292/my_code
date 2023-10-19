

import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_parents_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_personal_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_transport_model.dart';
import 'package:get/get.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ProfileController extends GetxController{

  PageController profilePageController = PageController();

  @override
  void onInit() {
    fetchProfilePersonalData();
    fetchProfileParentsData();
    fetchProfileTransportData();
    super.onInit();
  }


  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  ProfilePersonal? profilePersonal;
  ProfileParents? profileParents;
  ProfileTransport? profileTransport;



  void fetchProfilePersonalData() async {


    isLoading.value = true;


    try {
      final res = await BaseClient().getData(
        url: InfixApi.profilePersonal(),
        header: {
          'Authorization': "${GlobalVariableController.token}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },

      );


      ProfilePersonalModel profilePersonalModel = ProfilePersonalModel.fromJson(res);

      if (profilePersonalModel.success == true) {

        profilePersonal = profilePersonalModel.data?.profilePersonal;
        isLoading.value = false;



      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profilePersonalModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchProfileParentsData() async {


    isLoading.value = true;


    try {
      final res = await BaseClient().getData(
        url: InfixApi.profileParents(),
        header: {
          'Authorization': "${GlobalVariableController.token}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },

      );


      ProfileParentsModel profileParentsModel = ProfileParentsModel.fromJson(res);

      if (profileParentsModel.success == true) {

        profileParents = profileParentsModel.data?.profileParents;
        isLoading.value = false;



      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileParentsModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchProfileTransportData() async {


    isLoading.value = true;


    try {
      final res = await BaseClient().getData(
        url: InfixApi.profileTransport(),
        header: {
          'Authorization': "${GlobalVariableController.token}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },

      );


      ProfileTransportModel profileTransportModel = ProfileTransportModel.fromJson(res);

      if (profileTransportModel.success == true) {

        profileTransport = profileTransportModel.data?.profileTransport;
        isLoading.value = false;



      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileTransportModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }
}