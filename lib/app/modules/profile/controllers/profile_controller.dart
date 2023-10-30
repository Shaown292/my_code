

import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile/profile_others_model.dart';
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
    fetchProfileOthersData();
    super.onInit();
  }


  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  ProfilePersonal? profilePersonal;
  ProfileParents? profileParents;
  ProfileTransport? profileTransport;
  ProfileOthers? profileOthers;
  String? firstName ;


  void fetchProfilePersonalData() async {


    isLoading.value = true;


    try {
      final res = await BaseClient().getData(
        url: InfixApi.profilePersonal(),
        header: GlobalVariableController.header,

      );


      ProfilePersonalModel profilePersonalModel = ProfilePersonalModel.fromJson(res);

      if (profilePersonalModel.success == true) {

        profilePersonal = profilePersonalModel.data?.profilePersonal;
        isLoading.value = false;
        debugPrint("Roll number is:::::: ${profilePersonal?.roll}");

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
        header: GlobalVariableController.header,


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
        header: GlobalVariableController.header,

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

  void fetchProfileOthersData() async {


    isLoading.value = true;


    try {
      final res = await BaseClient().getData(
        url: InfixApi.profileOthers(),
        header:GlobalVariableController.header

      );


      ProfileOthersModel profileOthersModel = ProfileOthersModel.fromJson(res);

      if (profileOthersModel.success == true) {

        profileOthers = profileOthersModel.data?.profileOthers;
        isLoading.value = false;



      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${profileOthersModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }
}