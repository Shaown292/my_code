import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_edit_model/student_profile_edit_response_model.dart';
import 'package:get/get.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/profile_edit_model/profile_data_controller.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';
import 'package:http/http.dart' as http;

class ProfileEditController extends GetxController {
  @override
  void onInit() {
    _initialize();
    super.onInit();
  }

  ProfileDataController profileDataController = Get.find();
  LoadingController loadingController = Get.find();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  void _initialize() {
    firstName.text = profileDataController.firstName.toString();
    lastName.text = profileDataController.lastName.toString();
    email.text = profileDataController.email.toString();
    phoneNumber.text = profileDataController.phoneNumber.toString();
    dateOfBirth.text = profileDataController.dateOfBirth.toString();
    currentAddress.text = profileDataController.presentAddress.toString();
  }

  void userProfileInfoUpdate() async {
    try {
      final response = await BaseClient().postData(
        url: InfixApi.updateProfile(GlobalVariableController.roleId!),
        header: GlobalVariableController.header,
        payload: {
          "first_name": firstName.text,
          "last_name": lastName.text,
          "date_of_birth": dateOfBirth.text,
          "current_address": currentAddress.text,
        },
      );

      StudentProfileEditResponseModel profileEditResponseModel =
          StudentProfileEditResponseModel.fromJson(response);
      if (profileEditResponseModel.success == true) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(
            message: profileEditResponseModel.message ??
                'Profile Updated Successfully');

        _saveUpdateData(profileEditResponseModel: profileEditResponseModel);
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message:
                profileEditResponseModel.message ?? 'Something Went Wrong.');
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  void profilePhotoUpdate({required String file}) async {
    try {
      var headers = GlobalVariableController.header;
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(InfixApi.studentProfilePhotoUpdate(
              studentId: GlobalVariableController.studentId!)));
      request.files.add(await http.MultipartFile.fromPath('photo', file));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String res = await response.stream.bytesToString();
      Map<String, dynamic> resMap = json.decode(res);
      StudentProfileEditResponseModel profileEditResponseModel =
          StudentProfileEditResponseModel.fromJson(resMap);
      debugPrint('$resMap');

      if (profileEditResponseModel.success == true) {
        profileDataController.profilePickedImage.value = File('');
        showBasicSuccessSnackBar(
            message: profileEditResponseModel.message ??
                'Profile Updated Successfully');

        _saveUpdateData(profileEditResponseModel: profileEditResponseModel);
      } else {
        showBasicFailedSnackBar(
            message:
                profileEditResponseModel.message ?? 'Something Went Wrong.');
        profileDataController.profilePickedImage.value = File('');
      }
    } catch (e, t) {
      profileDataController.profilePickedImage.value = File('');
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      profileDataController.profilePickedImage.value = File('');
    }
  }

  void _saveUpdateData(
      {required StudentProfileEditResponseModel profileEditResponseModel}) {
    profileDataController.firstName.value =
        profileEditResponseModel.data?.profilePersonal?.firstName ?? '';
    profileDataController.lastName.value =
        profileEditResponseModel.data?.profilePersonal?.lastName ?? '';
    profileDataController.email.value =
        profileEditResponseModel.data?.profilePersonal?.email ?? '';
    profileDataController.phoneNumber.value =
        profileEditResponseModel.data?.profilePersonal?.mobile ?? '';
    profileDataController.dateOfBirth.value =
        profileEditResponseModel.data?.profilePersonal?.dateOfBirth ?? '';
    profileDataController.presentAddress.value =
        profileEditResponseModel.data?.profilePersonal?.currentAddress ?? '';
    profileDataController.profilePhoto.value =
        profileEditResponseModel.data?.profilePersonal?.studentPhoto ?? '';
  }
}
