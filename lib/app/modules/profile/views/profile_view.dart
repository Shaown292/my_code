import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';

class ProfileView extends GetView<ProfileController>{
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        actions: [
          Image.asset(ImagePath.edit)
        ],
      ),
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.appBackgroundColor],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagePath.calender)
                          )
                        ),
                      ),
                      10.horizontalSpacing,
                       const Column(
                        children: [
                          Text(
                            "Date of birth",
                            style: TextStyle(
                              color: AppColors.profileSecondaryColor
                            ),
                          ),
                          Text(
                            AppText.dateOfBirth,
                            style: TextStyle(
                                color: AppColors.profileHighlightedColor
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  10.verticalSpacing,
                  const Divider(
                    thickness: 2,
                    color: AppColors.profileDividerColor,
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}