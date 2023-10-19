import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../../../data/constants/image_path.dart';
import '../common_widgets/alert_dialog.dart';

class CustomAppBar extends GetView<HomeController> {

  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({this.centerTitle = false, super.key, this.leadingIcon, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, bottom: 20, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
             10.horizontalSpacing,
             leadingIcon ?? InkWell(
               onTap: Get.back,
               child: Container(
                 height: 20,
                 width: 20,
                 decoration:  const BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage( ImagePath.back),
                       filterQuality: FilterQuality.high
                   ),
                 ),
               ),
             ),
             10.horizontalSpacing,
             Text(
               title ?? "",
               style: AppTextStyle.textStyle16WhiteW500,
             ),

           ],
     ),
          Row(
            children:   actions ??
                [
                  InkWell(
                    onTap: (){
                      Get.dialog(
                        AccountDeleteDialogue(
                          onYesTap: () {
                            controller.logout();
                          },
                          title: 'Confirmation',
                          subTitle: AppText.logoutWarningMsg,
                          noText: 'cancel',
                          yesText: 'logout',
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 17,
                        width: 17,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagePath.logout),
                              filterQuality: FilterQuality.high
                          ),
                        ),
                      ),
                    ),
                  )
                ],
          ),
        ],
      )
    );
  }
}
