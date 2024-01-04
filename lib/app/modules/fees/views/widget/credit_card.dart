import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CreditCard extends StatelessWidget {
  final String? bankName;
  final String? accountName;
  final String? type;
  final double? accountNumber;

  const CreditCard({
    super.key,
    this.bankName,
    this.accountName,
    this.type,
    this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bankName ?? "",
          style: AppTextStyle.blackFontSize14W400,
        ),
        10.verticalSpacing,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ColumnTile(
            title: "Account Name",
              value: accountName,
            ),
             ColumnTile(
               width: Get.width * 0.25,
            title: "Account Number",
              value: accountNumber.toString(),
            ),
             ColumnTile(
            title: "Type",
              value: type ,
            ),
          ],
        ),
      ],
    );
  }
}