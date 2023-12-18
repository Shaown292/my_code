import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Forget Password",
      actions: const [
        SizedBox(),
      ],
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    50.verticalSpacing,
                    const Text(
                      "Password Recovery",
                      style: TextStyle(
                          color: Color(0xFF48484A),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    30.verticalSpacing,
                    CustomTextFormField(
                      controller: controller.forgetTextController,
                      fillColor: Colors.white,
                      hintText: "Type email address",
                      hintTextStyle: const TextStyle(
                          color: Color(0xFF324844),
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      focusBorderActive: true,
                      enableBorderActive: true,
                      contentPadding: const EdgeInsets.only(
                          left: 20, top: 15, bottom: 15),
                    ),
                    10.verticalSpacing,
                     const Text(
                      AppText.enterYourMailText,
                      style: TextStyle(
                          color: Color(0xFF636366),
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    30.verticalSpacing,
                    PrimaryButton(
                      title: "Recover My Password",
                      height: Get.height * 0.05,
                      radius: 6,
                      onTap: (){
                        controller.forgetPassword();
                        debugPrint(
                            "Email is ${controller.forgetTextController}");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
