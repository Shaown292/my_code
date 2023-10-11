import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/widget/page_indicator.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/widget/pages_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/dummy_data/student/student_info_dummy_data.dart';
import '../widget/parents_profile_widget.dart';
import '../widget/personal_profile_widget.dart';
import '../widget/transport_profile_widget.dart';

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
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
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
                                          height: 75,
                                          width: 75,
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
                                                  "Class",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "XI-B",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "|",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "Section:",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "D",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Admission No:",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "8776",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "|",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "Roll:",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                5.horizontalSpacing,
                                                const Text(
                                                  "04",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .profileCardTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                        height: 20,
                                        width: 20,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PageView(
                        controller: controller.profilePageController,
                        physics: const NeverScrollableScrollPhysics(),
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
