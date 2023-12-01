import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../controllers/admin_route_controller.dart';

class AdminRouteView extends GetView<AdminRouteController> {
  const AdminRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: InfixEduScaffold(
        title: "Route",
        body: CustomBackground(
          customWidget: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TabBar(
                  labelColor: AppColors.profileValueColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
                  indicatorColor: AppColors.profileIndicatorColor,
                  controller: controller.tabController,
                  tabs: List.generate(
                    controller.tabs.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        controller.tabs[index],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: controller.routeTitleTextController,
                            enableBorderActive: true,
                            focusBorderActive: true,
                            hintText: "Route Title",
                            hintTextStyle:
                                AppTextStyle.fontSize14lightBlackW400,
                            fillColor: Colors.white,
                          ),
                          10.verticalSpacing,
                          CustomTextFormField(
                            controller: controller.routeFareTextController,
                            enableBorderActive: true,
                            focusBorderActive: true,
                            hintText: "Route fare",
                            hintTextStyle:
                                AppTextStyle.fontSize14lightBlackW400,
                            fillColor: Colors.white,
                          ),
                          30.verticalSpacing,
                          PrimaryButton(
                            text: "Save",
                            onTap: () {},
                          ),
                        ],
                      ),
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
