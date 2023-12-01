import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:get/get.dart';

class AdminTransportDetailsController extends GetxController {

  void showBookListDetailsBottomSheet({required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.55,
        color: bottomSheetBackgroundColor,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpacing,
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text( "Routes", style:  AppTextStyle.fontSize14BlackW500,),
            ),
            const BottomSheetTile(
              title: "Vehicle No",
              value: "1001",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Vehicle Model",
              value: "Infix 12212",
              color:  Colors.white,
            ),
            const BottomSheetTile(
              title: "Made Year",
              value: "2023",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Driver Name",
              value: "Rohit Sharam",
              color:  Colors.white,
            ),
            const BottomSheetTile(
              title: "License",
              value: "Dhaka Metro B 2010",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Driver Contact",
              value: "01215412254",
              color:  Colors.white,
            ),

          ],
        )
      ),
      shape: defaultBottomSheetShape(),
    );
  }
}
