import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_internet/InternetController.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/constants/app_colors.dart';
import '../../../utilities/message/snack_bars.dart';
import '../../../utilities/widgets/common_widgets/custom_elevated_button.dart';
import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../../../utilities/widgets/no_internet/no_internet_widget.dart';
import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  TextEditingController emailTextController=TextEditingController();
  TextEditingController passwordTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => internetController.internet.isTrue ? Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(

          child: Container(
            height: Get.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.appBackgroundColor],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: 38,
                        width: 130,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImagePath.appLogo),
                            )
                        ),
                      )
                  ),
                  Container(
                    height: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        /// Demo Login Bar
                        30.verticalSpacing,
                        AppConfig.isDemo ? const SizedBox() : Row(
                          children: <Widget>[
                            CustomElevatedButton(
                              onPressed: () {
                                controller.demoUserLogin(role: 2);
                              },
                              text: 'Student',
                              topLeft: 8.0,
                              bottomLeft: 8.0,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                controller.demoUserLogin(role: 4);
                              },
                              text: 'Teacher',
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                controller.demoUserLogin(role: 3);
                              },
                              text: 'Parent',
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                controller.demoUserLogin(role: 1);
                              },
                              text: 'Admin',
                              topRight: 8.0,
                              bottomRight: 8.0,
                            ),
                          ],
                        ),
                        30.verticalSpacing,

                        /// Text field
                        CustomTextFormField(
                          controller: emailTextController,
                          fillColor: const Color(0xFFFDFBFF),
                          focusBorderActive: true,
                          enableBorderActive: true,
                          hintText: "Email",
                          suffixIcon: const Icon(
                            Icons.email,
                            color: AppColors.loginIconColor,
                          ),
                        ),
                        10.verticalSpacing,
                        CustomTextFormField(
                          iconOnTap: () {
                          },
                          controller: passwordTextController,
                          fillColor: const Color(0xFFF4EBFC),
                          hintText: "Password",
                          focusBorderActive: true,
                          enableBorderActive: true,
                          suffixIcon: const Icon(
                            Icons.lock,
                            // passwordVisible ? Icons.lock : Icons.lock_open,
                            color: AppColors.loginIconColor,
                          ),
                        ),
                        60.verticalSpacing,
                        controller.isLoading.value ? const CircularProgressIndicator() : PrimaryButton(
                          onTap: (){

                            if(validate()){
                              controller.isLoading.value = true;
                              controller.userLogin(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                              );
                            }

                          },
                          text: 'Login',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ) : const NoInternetConnection());
  }

  bool validate() {
    String email=emailTextController.text;
    String password=passwordTextController.text;
    if(email.isEmpty){
      showBasicFailedSnackBar(message: 'Enter email');
      return false;
    }
    else if(password.isEmpty){
      showBasicFailedSnackBar(message: 'Enter password');
      return false;
    }
    return true;
  }

}