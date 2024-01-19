import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/bank_payment_list/views/widget/bank_payment_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/bank_payment_list_controller.dart';

class BankPaymentListView extends GetView<BankPaymentListController> {
  const BankPaymentListView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Bank Payment",
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
                unselectedLabelStyle:
                AppTextStyle.fontSize12LightGreyW500,
                indicatorColor: AppColors.profileIndicatorColor,
                controller: controller.tabController,
                tabs: List.generate(
                  controller.status.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      controller.status[index],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                  itemBuilder: (context, index){
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BankPaymentTile(
                    studentName: "Rohim Molla",
                    date: "16th June",
                    amount: "540",
                    status: "Pending",
                    statusColor: Colors.redAccent,
                    onTap: (){},
                    color: Colors.white,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
