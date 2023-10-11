import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/pages_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/parents_profile_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/personal_profile_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/transport_profile_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/dummy_data/student/student_info_dummy_data.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          actions: [Image.asset(ImagePath.edit)],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.appBackgroundColor],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: Get.height,

              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    child: Container(
                      height: Get.height * 0.2,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: Get.height *0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.profileCardBackgroundColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Get.height * 0.1,
                                          width: Get.height * 0.1,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(ImagePath.dp),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        10.horizontalSpacing,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Akshay Syal",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  AppText.profileClass,
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "XI-B",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "|",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  AppText.profileSection,
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "D",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  AppText.profileAdmission,
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "8776",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "|",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  AppText.profileRoll,
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "04",
                                                  style: AppTextStyle.fontSize14LightPinkW400,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: Get.width * 0.04,
                                        width: Get.width * 0.04,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(ImagePath.camera),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          10.verticalSpacing,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: PageWidget(controller: controller,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  30.verticalSpacing,

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: PageView(
                        controller: controller.profilePageController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          PersonalProfileWidget(studentInfo: studentInfo),
                          const ParentsProfileWidget(),
                          const TransportProfileWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
