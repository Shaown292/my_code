import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_fees_invoice_controller.dart';

class AdminFeesInvoiceView extends GetView<AdminFeesInvoiceController> {
  const AdminFeesInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Fees Invoice",
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ],
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 25,
                    width: 75,
                    child: Image.asset(
                      ImagePath.appLogo,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Invoice No: ",
                        style: AppTextStyle.homeworkElements,
                      ),
                      Text(
                        "Created Date: ",
                        style: AppTextStyle.homeworkElements,
                      ),
                      Text(
                        "Due Date: ",
                        style: AppTextStyle.homeworkElements,
                      ),
                    ],
                  ),
                ],
              ),
              10.verticalSpacing,
              const Text(
                "Annual Exam Fee",
                style: AppTextStyle.fontSize14BlackW500,
              ),
               10.verticalSpacing,
               Row(
                children: [
                  ColumnTile(
                    title: "Amount",
                    value:  "",
                    width: Get.width * 0.18,
                  ),
                  ColumnTile(
                    title: "Waiver",
                    value: "",
                    width: Get.width * 0.18,
                  ),
                  ColumnTile(
                    title: "Fine",
                    value:  "",
                    width: Get.width * 0.18,
                  ),
                  ColumnTile(
                    title: "Paid",
                    value:  "",
                    width: Get.width * 0.18,
                  ),
                  ColumnTile(
                    title: "Total",
                    value:  "",
                    width: Get.width * 0.18,
                  ),

                ],
              ),
              5.verticalSpacing,
              CustomDivider(
                width: Get.width,
                color: AppColors.customDividerColor,
              ),
              10.verticalSpacing,
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Amount",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      const Text(
                        "Total Waiver",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      const Text(
                        "Total Fine",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      const Text(
                        "Total Paid",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      const Text(
                        "Grand Total",
                        style: AppTextStyle.homeworkElements,
                      ),
                      5.verticalSpacing,
                      const Text(
                        "Due Balance",
                        style: AppTextStyle.fontSize14lightBlackW400,
                      ),
                    ],
                                 ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       const Text(
                         "Total Amount",
                         style: AppTextStyle.homeworkElements,
                       ),
                       5.verticalSpacing,
                       const Text(
                         "Total Waiver",
                         style: AppTextStyle.homeworkElements,
                       ),
                       5.verticalSpacing,
                       const Text(
                         "Total Fine",
                         style: AppTextStyle.homeworkElements,
                       ),
                       5.verticalSpacing,
                       const Text(
                         "Total Paid",
                         style: AppTextStyle.homeworkElements,
                       ),
                       5.verticalSpacing,
                       const Text(
                         "Grand Total",
                         style: AppTextStyle.homeworkElements,
                       ),
                       5.verticalSpacing,
                       const Text(
                         "Due Balance",
                         style: AppTextStyle.fontSize14lightBlackW400,
                       ),
                     ],
                   ),
                 ],
               ),

            ],
          ),
        ),
      ),
    );
  }
}
