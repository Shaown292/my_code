import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_status_tile/show_status_tile.dart';

import 'package:get/get.dart';

import '../controllers/student_wallet_controller.dart';

class StudentWalletView extends GetView<StudentWalletController> {
  const StudentWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "My Wallet",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PrimaryButton(
                      text: "Balance : 30000",
                      borderRadius: 6,
                      padding: EdgeInsets.all(10),
                    ),
                    PrimaryButton(
                      text: "Add Balance",
                      borderRadius: 6,
                      padding: const EdgeInsets.all(10),
                      onTap: () => controller.showAddBalanceBottomSheet(
                        color: Colors.white,
                        controller: controller.amountTextController,
                      ),
                    ),
                  ],
                ),
                20.verticalSpacing,
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return const ShowStatusTile(
                        firstTitle: "Date",
                        firstValue: "07-12-2023",
                        secondTitle: "Method",
                        secondValue: "Cheque",
                        thirdTitle: "Amount",
                        thirdValue: "3000",
                        activeStatus: "Approved",
                        activeStatusColor: AppColors.activeStatusRedColor,
                      );
                    }),
                30.verticalSpacing,

              ],
            ),
          ),
        ),
      ),
    );
  }
}
