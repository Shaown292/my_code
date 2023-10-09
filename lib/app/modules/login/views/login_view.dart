import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/custom_elevated_button.dart';
import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Container(
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
                      30.verticalSpacing,
                      Row(
                        children: <Widget>[
                          CustomElevatedButton(
                            onPressed: () {},
                            text: 'Student',
                            topLeft: 8.0,
                            bottomLeft: 8.0,
                          ),
                          CustomElevatedButton(
                            onPressed: () {},
                            text: 'Teacher',
                          ),
                          CustomElevatedButton(
                            onPressed: () {},
                            text: 'Parent',
                            topRight: 8.0,
                            bottomRight: 8.0,
                          ),
                        ],
                      ),
                      30.verticalSpacing,
                      const CustomTextFormField(
                        fillColor: Color(0xFFFDFBFF),
                        focusBorderActive: true,
                        enableBorderActive: true,
                        hintText: "Email",
                        suffixIcon: Icon(
                          Icons.email,
                          color: AppColors.loginIconColor,
                        ),
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        iconOnTap: () {
                        },
                        // obsCureText: passwordVisible,
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
                      PrimaryButton(
                        onTap: () => Get.offAndToNamed(Routes.PROFILE),
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
    );
  }
}
