
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_edit/profile_edit_model.dart';
import 'package:get/get.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../utilities/message/snack_bars.dart';


class ProfileEditController extends GetxController {

  @override
  void onInit() {
    print("Edit");
    fetchProfileData();
    super.onInit();
  }



  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  RxBool isLoading = false.obs;


  Future<void> fetchProfileData() async {


      isLoading.value = true;
      int studentId = AuthDatabase.instance.getUserInfo()!.data.user.studentId;

      try {
        final res = await BaseClient().getData(
          url: InfixApi.editProfile(studentId.toString()),
          header: {
            'Authorization': "${AuthDatabase.instance.getToken()}",
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },

        );


        ProfileEditModel profileEditModel = ProfileEditModel.fromJson(res);

        if (profileEditModel.success == true) {

          var data =  profileEditModel.data?.studentDetail;
          isLoading.value = false;

          firstNameController.text = data?.firstName ?? "";
          lastNameController.text = data?.lastName ?? "" ;
          email.text = data?.email ?? "" ;
          phoneNumber.text = data?.mobile ?? "" ;
          dateOfBirth.text = data?.dateOfBirth ?? "" ;
          currentAddress.text = data?.currentAddress ?? "" ;

        } else {
          isLoading.value = false;
          showBasicFailedSnackBar(message: "${profileEditModel.message}");
        }
      } catch (e, t) {
        debugPrint('$e');
        debugPrint('$t');
      } finally {
        isLoading.value = false;
      }
    }


}
