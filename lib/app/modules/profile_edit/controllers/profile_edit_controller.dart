
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_edit/profile_edit_model.dart';

import 'package:get/get.dart';


import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/profile/profile_personal_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';



class ProfileEditController extends GetxController {

  @override
  void onInit() {

    // userProfileInfoUpdate();
    initialize();
    super.onInit();
  }



  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  LoadingController loadingController = Get.find();


  void initialize(){
    ProfilePersonal? profilePersonal = Get.arguments["profile_personal"];


      firstName.text = profilePersonal?.firstName ?? "First";
      lastName.text = profilePersonal?.lastName ?? "Last name";
      email.text = profilePersonal?.email ?? "Email";
      phoneNumber.text = profilePersonal?.mobile ?? "Phone number";
      dateOfBirth.text = profilePersonal?.dateOfBirth ?? "Date of Birth";
      currentAddress.text = profilePersonal?.currentAddress ?? "Phone number";


  }

  void userProfileInfoUpdate() async {
    ProfileEditModel? profileEditModel;

    try {
      print(firstName.text);
      final res = await BaseClient().postData(
        url: InfixApi.updateProfile(GlobalVariableController.roleId!),
        header: GlobalVariableController.header,
        payload: {
          "first_name": firstName.text,
          "last_name": lastName.text,
          "date_of_birth": dateOfBirth.text,
          "current_address": currentAddress.text,
        },

      );

      profileEditModel = ProfileEditModel.fromJson(res);
      if (profileEditModel.success == true) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: profileEditModel.message ?? 'Profile Updated Successfully');
        print("data $firstName");
        print("data $lastName");

      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: profileEditModel.message!);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }




}
