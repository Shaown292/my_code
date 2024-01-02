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
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      text: "Balance : ${controller.balance}",
                      borderRadius: 6,
                      padding: const EdgeInsets.all(10),
                    ),
                    PrimaryButton(
                      text: "Add Balance",
                      borderRadius: 6,
                      padding: const EdgeInsets.all(10),
                      onTap: () => controller.showAddBalanceBottomSheet(
                        color: Colors.white,
                        amountController: controller.amountTextController,
                        noteController: controller.noteTextController,
                        browseFileTextController: controller.browseFileTextController,
                      ),
                    ),
                  ],
                ),),
                20.verticalSpacing,
                Obx(() => controller.isLoading.value ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.paymentList.length,
                    itemBuilder: (context, index) {
                      return ShowStatusTile(
                        firstTitle: "Date",
                        firstValue: DateTime.tryParse(controller.paymentList[index].createdAt ?? '')?.yyyy_mm_dd,
                        secondTitle: "Method",
                        secondValue: controller.paymentList[index].paymentMethod,
                        thirdTitle: "Amount",
                        thirdValue: controller.paymentList[index].amount.toString(),
                        activeStatus: controller.paymentList[index].status,
                        activeStatusColor: AppColors.activeStatusRedColor,
                      );
                    })),
                30.verticalSpacing,

              ],
            ),
          ),
        ),
      ),
    );
  }
}
