import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/staff_individual_details_controller.dart';

class StaffIndividualDetailsView
    extends GetView<StaffIndividualDetailsController> {
  const StaffIndividualDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Individual",
      body: CustomBackground(
        customWidget: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
