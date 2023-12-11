import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:get/get.dart';

class TeLibraryController extends GetxController {

  void showBookListDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
          height: Get.height * 0.55,
          color: bottomSheetBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                   'Title',
                  style: AppTextStyle.fontSize14BlackW500,
                ),
              ),
              const BottomSheetTile(
                title: "Book No",
                value:  '101',
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Subject",
                value: "Subject",
                color: Colors.white,
              ),
              const BottomSheetTile(
                title: "Publisher Name",
                value: "Shanto bhai",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Author Name",
                value: "Humyun",
                color: Colors.white,
              ),
              const BottomSheetTile(
                title: "Quantity",
                value:"3",
                color: AppColors.homeworkWidgetColor,
              ),
              const BottomSheetTile(
                title: "Price",
                value: "1010",
                color: Colors.white,
              ),
            ],
          )),
      shape: defaultBottomSheetShape(),
    );
  }
}
