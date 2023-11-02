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
    // userProfileInfoUpdate();
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
    // ProfilePersonal? profilePersonal = Get.arguments["profile_personal"];

    // firstName.text = profilePersonal?.firstName ?? "First";
    // lastName.text = profilePersonal?.lastName ?? "Last name";
    // email.text = profilePersonal?.email ?? "Email";
    // phoneNumber.text = profilePersonal?.mobile ?? "Phone number";
    // dateOfBirth.text = profilePersonal?.dateOfBirth ?? "Date of Birth";
    // currentAddress.text = profilePersonal?.currentAddress ?? "Phone number";

    firstName.text = profileDataController.firstName.toString();
    lastName.text = profileDataController.lastName.toString();
    email.text = profileDataController.email.toString();
    phoneNumber.text = profileDataController.phoneNumber.toString();
    dateOfBirth.text = profileDataController.dateOfBirth.toString();
    currentAddress.text = profileDataController.presentAddress.toString();
  }

  void userProfileInfoUpdate() async {
    try {
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

      StudentProfileEditResponseModel profileEditResponseModel =
          StudentProfileEditResponseModel.fromJson(res);
      if (profileEditResponseModel.success == true) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(
            message: profileEditResponseModel.message ??
                'Profile Updated Successfully');

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
            profileEditResponseModel.data?.profilePersonal?.currentAddress ??
                '';
        profileDataController.profilePhoto.value =
            profileEditResponseModel.data?.profilePersonal?.studentPhoto ?? '';
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: profileEditResponseModel.message ?? 'Something Went Wrong.');
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }


  void profilePhotoUpdate() async {

    var headers = GlobalVariableController.header;
    var request = http.MultipartRequest('POST', Uri.parse('https://spondan.com/infixedu/api/v2/student-profile-img-update/1'));
    request.files.add(await http.MultipartFile.fromPath('photo', '/Users/dev09/Desktop/Screenshot 2023-10-24 at 12.58.36 PM.png'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }


  }


}
