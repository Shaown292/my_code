import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/staff_individual_details/views/widget/individual_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';

import 'package:get/get.dart';

import '../controllers/staff_individual_details_controller.dart';

class StaffIndividualDetailsView
    extends GetView<StaffIndividualDetailsController> {
  const StaffIndividualDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "${controller.staffFirstName} ${controller.staffLastName}",
        body: CustomBackground(
          customWidget: controller.loadingController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.verticalSpacing,
                    controller.adminIndividualStaffDetailsResponseModel?.data
                                    ?.staffPhoto ==
                                null ||
                            controller.adminIndividualStaffDetailsResponseModel!
                                .data!.staffPhoto!.isEmpty
                        ? Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(ImagePath.dp),
                              ),
                            ),
                          )
                        : Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: 6.circularRadius,
                              child: CacheImageView(
                                url:
                                    '${AppConfig.imageBaseUrl}${controller.adminIndividualStaffDetailsResponseModel?.data?.staffPhoto.toString()}',
                                errorImageLocal: ImagePath.dp,
                              ),
                            ),
                          ),
                    50.verticalSpacing,
                    IndividualDetailsTile(
                      address: controller
                          .adminIndividualStaffDetailsResponseModel
                          ?.data
                          ?.currentAddress,
                      phone: controller.adminIndividualStaffDetailsResponseModel
                          ?.data?.mobile,
                      title: controller.adminIndividualStaffDetailsResponseModel
                          ?.data?.designation,
                      qualification: controller
                          .adminIndividualStaffDetailsResponseModel
                          ?.data
                          ?.qualification,
                      maritalStatus: controller
                          .adminIndividualStaffDetailsResponseModel
                          ?.data
                          ?.maritalStatus,
                      joiningDate: controller
                          .adminIndividualStaffDetailsResponseModel
                          ?.data
                          ?.dateOfJoining,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
