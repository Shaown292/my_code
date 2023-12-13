import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class BookIssuedController extends GetxController {

  LoadingController loadingController = Get.find();

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
              title: "Issued Date",
              value: "",
              color: AppColors.homeworkWidgetColor ,
            ),
            const BottomSheetTile(
              title: "Return date",
              value: "",
              color:  Colors.white,
            ),
            BottomSheetTile(
              title: "Author Name",
              value: "",
              color: AppColors.homeworkWidgetColor ,
            ),
            BottomSheetTile(
              title: "Status",
              value: "",
              color: Colors.white ,
            ),

          ],
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

}
