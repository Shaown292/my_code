import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/guardian_info.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/others_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/parents_info.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/tranport_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile_edit/views/widget/edit_profile_route.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/pages_widget.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/personal_profile_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      actions: [
        EditProfileRoute(controller: controller),
      ],
      leadingIcon: const SizedBox(),
      title: "Profile",
      body: CustomBackground(
        customWidget: Obx(() => Column(
              children: [
                Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.profileCardBackgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
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
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      10.horizontalSpacing,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.profilePersonal
                                                    ?.firstName ??
                                                "",
                                            style: AppTextStyle
                                                .fontSize18WhiteW500,
                                          ),
                                          Text(
                                            '${AppText.profileClass} ${controller.profilePersonal?.studentClass ?? ""}  |  ${AppText.profileSection} ${controller.profilePersonal?.section ?? ""}',
                                            style: AppTextStyle
                                                .fontSize14LightPinkW400,
                                          ),
                                          Text(
                                            '${AppText.profileAdmission} ${controller.profilePersonal?.admissionNo ?? ""}  |  ${AppText.profileRoll} ${controller.profilePersonal?.roll ?? ""}',
                                            style: AppTextStyle
                                                .fontSize14LightPinkW400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: PageWidget(
                            controller: controller,
                          ),
                        ),
                        5.verticalSpacing,
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  ProfilePersonalWidget(
                                      icon: ImagePath.calender,
                                      title: AppText.dateOfBirth,
                                      value: controller
                                          .profilePersonal?.dateOfBirth),
                                  ProfilePersonalWidget(
                                      icon: ImagePath.age,
                                      title: AppText.age,
                                      value: controller.profilePersonal?.age
                                          .toString()),
                                  ProfilePersonalWidget(
                                      icon: ImagePath.mail,
                                      title: AppText.phoneNumber,
                                      value:
                                          controller.profilePersonal?.mobile),
                                  ProfilePersonalWidget(
                                      icon: ImagePath.phone,
                                      title: AppText.email,
                                      value: controller.profilePersonal?.email),
                                  ProfilePersonalWidget(
                                      icon: ImagePath.address,
                                      title: AppText.presentAddress,
                                      value: controller
                                          .profilePersonal?.currentAddress),
                                ],
                              ),
                        controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  ParentsInfo(
                                      designation: AppText.profileFather,
                                      icon: ImagePath.parentsProfile,
                                      name: controller
                                              .profileParents?.fathersName ??
                                          AppText.noDataAvailable,
                                      phone: controller
                                              .profileParents?.fathersMobile ??
                                          AppText.noDataAvailable,
                                      occupation: controller.profileParents
                                              ?.fathersOccupation ??
                                          AppText.noDataAvailable),
                                  20.verticalSpacing,
                                  ParentsInfo(
                                      designation: AppText.profileMother,
                                      icon: ImagePath.parentsProfile,
                                      name: controller
                                              .profileParents?.mothersName ??
                                          AppText.noDataAvailable,
                                      phone: controller
                                              .profileParents?.mothersMobile ??
                                          AppText.noDataAvailable,
                                      occupation: controller.profileParents
                                              ?.mothersOccupation ??
                                          AppText.noDataAvailable),
                                  20.verticalSpacing,
                                  GuardianInfo(
                                    designation: AppText.profileGuardian,
                                    icon: ImagePath.parentsProfile,
                                    name: controller
                                            .profileParents?.guardiansName ??
                                        AppText.noDataAvailable,
                                    email: controller
                                            .profileParents?.guardiansEmail ??
                                        AppText.noDataAvailable,
                                    phone: controller
                                            .profileParents?.guardiansMobile ??
                                        AppText.noDataAvailable,
                                    occupation: controller.profileParents
                                            ?.guardiansOccupation ??
                                        AppText.noDataAvailable,
                                    relation: controller.profileParents
                                            ?.guardiansRelation ??
                                        AppText.noDataAvailable,
                                    other: "Other",
                                  )
                                ],
                              ),
                        controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  TransportWidget(
                                      title: AppText.transportRoute,
                                      value:
                                          controller.profileTransport?.route ??
                                              AppText.noDataAvailable),
                                  TransportWidget(
                                      title: AppText.transportVehicleNo,
                                      value: controller
                                              .profileTransport?.vehicle ??
                                          AppText.noDataAvailable),
                                  TransportWidget(
                                      title: AppText.transportDriverName,
                                      value:
                                          controller.profileTransport?.driver ??
                                              AppText.noDataAvailable),
                                  TransportWidget(
                                      title: AppText.transportDriverPhoneNo,
                                      value:
                                          controller.profileTransport?.mobile ??
                                              AppText.noDataAvailable),
                                  TransportWidget(
                                      title: AppText.transportDormitory,
                                      value: controller
                                              .profileTransport?.dormitory ??
                                          AppText.noDataAvailable),
                                ],
                              ),
                        controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  OthersTile(
                                      title: "Height",
                                      value:
                                          "${controller.profileOthers?.height ?? AppText.noDataAvailable}"),
                                  OthersTile(
                                      title: "Weight",
                                      value:
                                          "${controller.profileOthers?.weight ?? AppText.noDataAvailable}"),
                                  OthersTile(
                                      title: "National ID Number",
                                      value: controller
                                              .profileOthers?.nationalIdNo ??
                                          AppText.noDataAvailable),
                                  OthersTile(
                                      title: "Local ID Number",
                                      value:
                                          controller.profileOthers?.localIdNo ??
                                              AppText.noDataAvailable),
                                  OthersTile(
                                      title: "Bank Name",
                                      value:
                                          controller.profileOthers?.bankName ??
                                              AppText.noDataAvailable),
                                  OthersTile(
                                      title: "Bank Account Number",
                                      value: controller
                                              .profileOthers?.bankAccountNo ??
                                          AppText.noDataAvailable),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
