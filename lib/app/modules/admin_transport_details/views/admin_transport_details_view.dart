import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/admin_transport_details/views/widget/transport_details_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_transport_details_controller.dart';

class AdminTransportDetailsView
    extends GetView<AdminTransportDetailsController> {
  const AdminTransportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Transport Details",
      body: RefreshIndicator(
        onRefresh: () async {},
        color: AppColors.primaryColor,
        child: SingleChildScrollView(
          child: CustomBackground(
            customWidget: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return TransportDetailsTile(
                        route: "Mohammadpur",
                        vehicleNo: "10001",
                        onTap: () => controller.showBookListDetailsBottomSheet(index: index, bottomSheetBackgroundColor: Colors.white),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
