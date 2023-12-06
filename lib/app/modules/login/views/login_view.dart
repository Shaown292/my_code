import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/message/snack_bars.dart';
import '../../../utilities/widgets/common_widgets/custom_elevated_button.dart';
import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../../../utilities/widgets/no_internet/no_internet_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.internetController.internet.isTrue
        ? Scaffold(
            backgroundColor: AppColors.secondaryColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.appBackgroundColor
                      ],
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
                              height: Get.height * 0.1,
                              width: Get.width * 0.35,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(ImagePath.appLogo),
                                fit: BoxFit.contain,
                              )),
                            )),
                        Container(
                          height: 500,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /// Demo Login Bar
                              30.verticalSpacing,
                              AppConfig.isDemo
                                  ? const SizedBox()
                                  : Row(
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

                              /// Email Text field
                              CustomTextFormField(
                                controller: controller.emailTextController,
                                fillColor: Colors.white,
                                focusBorderActive: true,
                                enableBorderActive: true,
                                hintText: "Email",
                                contentPadding: const EdgeInsets.only(left: 15),
                                textInputType: TextInputType.text,
                                hintTextStyle:
                                    AppTextStyle.fontSize12LightViolateW500,
                                suffixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.loginIconColor,
                                ),
                              ),
                              10.verticalSpacing,

                              /// Password Text field
                              CustomTextFormField(
                                iconOnTap: () {
                                  controller.isObscureText.value =
                                      !controller.isObscureText.value;
                                },
                                controller: controller.passwordTextController,
                                obsCureText: controller.isObscureText.value,
                                fillColor: Colors.white,
                                hintText: "Password",
                                hintTextStyle:
                                    AppTextStyle.fontSize12LightViolateW500,
                                focusBorderActive: true,
                                enableBorderActive: true,
                                contentPadding: const EdgeInsets.only(left: 15),
                                suffixIcon: Icon(
                                  controller.isObscureText.value
                                      ? Icons.lock
                                      : Icons.lock_open,
                                  color: AppColors.loginIconColor,
                                ),
                              ),
                              15.verticalSpacing,
                              InkWell(
                                  onTap: () =>
                                      Get.toNamed(Routes.FORGET_PASSWORD),
                                  child: const Text(
                                    "Forget password?",
                                    style:
                                        AppTextStyle.cardTextStyle14PurpleW500,
                                  )),
                              60.verticalSpacing,

                              controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : PrimaryButton(
                                      onTap: () {
                                        if (validate()) {
                                          // controller.isLoading.value = true;
                                          controller.userLogin(
                                            email: controller
                                                .emailTextController.text,
                                            password: controller
                                                .passwordTextController.text,
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
          )
        : const NoInternetConnection());
  }

  bool validate() {
    String email = controller.emailTextController.text;
    String password = controller.passwordTextController.text;
    if (email.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter email');
      return false;
    } else if (password.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter password');
      return false;
    }
    return true;
  }
}
