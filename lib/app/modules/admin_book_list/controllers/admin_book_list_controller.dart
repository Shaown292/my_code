import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:get/get.dart';

class AdminBookListController extends GetxController {


  void showBookListDetailsBottomSheet({required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.55,
        color: bottomSheetBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpacing,
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text( "Title", style:  AppTextStyle.fontSize14BlackW500,),
            ),
            const BottomSheetTile(
              title: "Book No",
              value: "100",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "ISBN No",
              value: "ISBN",
              color:  Colors.white,
            ),
            const BottomSheetTile(
              title: "Category",
              value: "Category",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Subject",
              value: "Subject",
              color:  Colors.white,
            ),
            const BottomSheetTile(
              title: "Publisher Name",
              value: "Publisher xyz",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Author Name",
              value: "Humayan Ahmed",
              color:  Colors.white,
            ),
            const BottomSheetTile(
              title: "Quantity",
              value: "100",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Price",
              value: "\$100",
              color:  Colors.white,
            ),
          ],
        )

      ),
      shape: defaultBottomSheetShape(),
    );
  }
}
