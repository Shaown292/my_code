import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "About",
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      ImagePath.appLogo,
                      color: AppColors.primaryColor,
                      scale: 5,
                    ),
                  ),
                  const Text("Infix Edu", style: AppTextStyle.fontSize14BlackW500,),
                ],
              ),
              30.verticalSpacing,
              const Text("INFIX has all in one place. You’ll find everything what you are looking into education management system software. We care! User will never bothered in our real eye catchy user friendly UI & UX  Interface design. You know! Smart Idea always comes to well planners. And Our INFIX is Smart for its Well Documentation. Explore in new support world! It’s now faster & quicker. You’ll find us on Support Ticket, Email, Skype, WhatsApp.", style: AppTextStyle.fontSize13BlackW400,),
              20.verticalSpacing,
              const Text("Address: 89/2 Panthapath, Dhaka 1215, Bangladesh", style: AppTextStyle.cardTextStyle14PurpleW500,),
              10.verticalSpacing,
              const Text("Phone: +8801841412141", style: AppTextStyle.cardTextStyle14PurpleW500,),
              10.verticalSpacing,
              const Text("Email: admin@infixedu.com", style: AppTextStyle.cardTextStyle14PurpleW500,),
              10.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
