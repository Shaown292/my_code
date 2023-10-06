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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                ImagePath.appLogo,
                height: 37,
                width: 130,
              ),
              20.verticalSpacing,
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
                focusBorderActive: true,
                enableBorderActive: true,
                suffixIcon: const Icon(
                  Icons.lock,
                  // passwordVisible ? Icons.lock : Icons.lock_open,
                  color: AppColors.loginIconColor,
                ),
              ),
              20.verticalSpacing,
              PrimaryButton(
                onTap: () => Get.offAndToNamed(Routes.HOME),
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
