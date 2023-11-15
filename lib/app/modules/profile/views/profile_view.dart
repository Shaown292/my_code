import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/documents_card.dart';
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
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../../config/app_config.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/image_view/cache_image_view.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomBackground(
              customWidget: Obx(
                () => Column(
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
                                    color:
                                        AppColors.profileCardBackgroundColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          controller
                                                      .profileDataController
                                                      .profilePhoto
                                                      .value
                                                      .isEmpty ||
                                                  controller
                                                          .profileDataController
                                                          .profilePhoto
                                                          .value ==
                                                      ''
                                              ? Container(
                                                  height: Get.height * 0.1,
                                                  width: Get.height * 0.1,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            ImagePath.dp)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        6.circularRadius,
                                                    child: CacheImageView(
                                                      url:
                                                          '${AppConfig.imageBaseUrl}${controller.profileDataController.profilePhoto.toString()}',
                                                      errorImageLocal:
                                                          'assets/image/production/avatar.png',
                                                    ),
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
                                                '${controller.profileDataController.firstName}',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
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
                            /// Personal
                            controller.isLoading.value
                                ? const LoadingWidget()
                                : Column(
                                    children: [
                                      ProfilePersonalWidget(
                                        icon: ImagePath.calender,
                                        title: AppText.dateOfBirth,
                                        value:
                                            '${controller.profileDataController.dateOfBirth}',
                                      ),
                                      ProfilePersonalWidget(
                                          icon: ImagePath.age,
                                          title: AppText.age,
                                          value: controller.profilePersonal?.age
                                              .toString()),
                                      ProfilePersonalWidget(
                                        icon: ImagePath.mail,
                                        title: AppText.phoneNumber,
                                        value:
                                            '${controller.profileDataController.phoneNumber}',
                                      ),
                                      ProfilePersonalWidget(
                                        icon: ImagePath.phone,
                                        title: AppText.email,
                                        value:
                                            '${controller.profileDataController.email}',
                                      ),
                                      ProfilePersonalWidget(
                                        icon: ImagePath.address,
                                        title: AppText.presentAddress,
                                        value:
                                            '${controller.profileDataController.presentAddress}',
                                      ),
                                    ],
                                  ),

                            /// Parents
                            controller.isLoading.value
                                ? const LoadingWidget()
                                : Column(
                                    children: [
                                      ParentsInfo(
                                          designation: AppText.profileFather,
                                          icon: ImagePath.parentsProfile,
                                          name: controller.profileParents
                                                  ?.fathersName ??
                                              AppText.noDataAvailable,
                                          phone: controller.profileParents
                                                  ?.fathersMobile ??
                                              AppText.noDataAvailable,
                                          occupation: controller.profileParents
                                                  ?.fathersOccupation ??
                                              AppText.noDataAvailable),
                                      20.verticalSpacing,
                                      ParentsInfo(
                                          designation: AppText.profileMother,
                                          icon: ImagePath.parentsProfile,
                                          name: controller.profileParents
                                                  ?.mothersName ??
                                              AppText.noDataAvailable,
                                          phone: controller.profileParents
                                                  ?.mothersMobile ??
                                              AppText.noDataAvailable,
                                          occupation: controller.profileParents
                                                  ?.mothersOccupation ??
                                              AppText.noDataAvailable),
                                      20.verticalSpacing,
                                      GuardianInfo(
                                        designation: AppText.profileGuardian,
                                        icon: ImagePath.parentsProfile,
                                        name: controller.profileParents
                                                ?.guardiansName ??
                                            AppText.noDataAvailable,
                                        email: controller.profileParents
                                                ?.guardiansEmail ??
                                            AppText.noDataAvailable,
                                        phone: controller.profileParents
                                                ?.guardiansMobile ??
                                            AppText.noDataAvailable,
                                        occupation: controller.profileParents
                                                ?.guardiansOccupation ??
                                            AppText.noDataAvailable,
                                        relation: controller.profileParents
                                                ?.guardiansRelation ??
                                            AppText.noDataAvailable,
                                        other: "Other",
                                      ),
                                    ],
                                  ),

                            /// Transport
                            controller.isLoading.value
                                ? const LoadingWidget()
                                : Column(
                                    children: [
                                      TransportWidget(
                                          title: AppText.transportRoute,
                                          value: controller
                                                  .profileTransport?.route ??
                                              AppText.noDataAvailable),
                                      TransportWidget(
                                          title: AppText.transportVehicleNo,
                                          value: controller
                                                  .profileTransport?.vehicle ??
                                              AppText.noDataAvailable),
                                      TransportWidget(
                                          title: AppText.transportDriverName,
                                          value: controller
                                                  .profileTransport?.driver ??
                                              AppText.noDataAvailable),
                                      TransportWidget(
                                          title: AppText.transportDriverPhoneNo,
                                          value: controller
                                                  .profileTransport?.mobile ??
                                              AppText.noDataAvailable),
                                      TransportWidget(
                                          title: AppText.transportDormitory,
                                          value: controller.profileTransport
                                                  ?.dormitory ??
                                              AppText.noDataAvailable),
                                    ],
                                  ),

                            ///Others
                            controller.isLoading.value
                                ? const LoadingWidget()
                                : Column(
                                    children: [
                                      OthersTile(
                                          title: "Height",
                                          value: controller
                                                  .profileOthers?.height ??
                                              AppText.noDataAvailable),
                                      OthersTile(
                                          title: "Weight",
                                          value: controller
                                                  .profileOthers?.weight ??
                                              AppText.noDataAvailable),
                                      OthersTile(
                                          title: "National ID Number",
                                          value: controller.profileOthers
                                                  ?.nationalIdNo ??
                                              AppText.noDataAvailable),
                                      OthersTile(
                                          title: "Local ID Number",
                                          value: controller
                                                  .profileOthers?.localIdNo ??
                                              AppText.noDataAvailable),
                                      OthersTile(
                                          title: "Bank Name",
                                          value: controller
                                                  .profileOthers?.bankName ??
                                              AppText.noDataAvailable),
                                      OthersTile(
                                          title: "Bank Account Number",
                                          value: controller.profileOthers
                                                  ?.bankAccountNo ??
                                              AppText.noDataAvailable),
                                    ],
                                  ),

                            /// Documents Section
                            controller.isLoading.value
                                ? const LoadingWidget()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => controller
                                            .showUploadDocumentsBottomSheet(
                                                onTap: () {
                                          controller.pickFile();
                                        }, onTapForSave: () {
                                          controller.uploadDocuments();
                                        }),
                                        child: Container(
                                          width: 200,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: AppColors.appButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Transform.flip(
                                                flipY: true,
                                                child: Image.asset(
                                                  ImagePath.download,
                                                  scale: 4,
                                                ),
                                              ),
                                              5.horizontalSpacing,
                                              const Text(
                                                "Upload Document",
                                                style: AppTextStyle
                                                    .cardTextStyle14WhiteW500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      10.verticalSpacing,

                                      /// Documents Tiles
                                      controller.loadingController.isLoading
                                          ? const LoadingWidget()
                                          : controller
                                                  .documentsDataList.isNotEmpty
                                              ? Expanded(
                                                  child: ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .documentsDataList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return DocumentsCard(
                                                        title:
                                                            "${index + 1}. ${controller.documentsDataList[index].title}",
                                                        fileName: controller
                                                            .documentsDataList[
                                                                index]
                                                            .file,
                                                        tapDelete: () =>
                                                            Get.dialog(
                                                          AccountDeleteDialogue(
                                                            onYesTap: () async {
                                                              await controller
                                                                  .deleteDocumentList(
                                                                      controller
                                                                          .documentsDataList[
                                                                              index]
                                                                          .id!);
                                                              await controller
                                                                  .getAllDocumentList();
                                                            },
                                                            title:
                                                                'Confirmation',
                                                            subTitle: AppText
                                                                .logoutWarningMsg,
                                                            noText: 'cancel',
                                                            yesText: 'logout',
                                                          ),
                                                        ),
                                                        tapDownload: () {},
                                                      );
                                                    },
                                                  ),
                                                )
                                              : const NoDataAvailableWidget(
                                                  message:
                                                      "No Document Available",
                                                ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
