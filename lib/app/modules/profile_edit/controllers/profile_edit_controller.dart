
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


import '../../../../domain/core/model/profile/profile_personal_model.dart';



class ProfileEditController extends GetxController {

  @override
  void onInit() {

    //fetchProfileData();
    initialize();

    super.onInit();
  }



  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  RxBool isLoading = false.obs;


  void initialize(){

    ProfilePersonal? profilePersonal = Get.arguments["profile_personal"];

    if(profilePersonal != null) {

      firstName.text = profilePersonal.firstName ?? "First name";
      lastName.text = profilePersonal.lastName ?? "Last name";
      email.text = profilePersonal.email ?? "Email";
      phoneNumber.text = profilePersonal.mobile ?? "Phone number";
      dateOfBirth.text = profilePersonal.dateOfBirth ?? "Date of Birth";
      currentAddress.text = profilePersonal.currentAddress ?? "Phone number";

    }
  }




}
