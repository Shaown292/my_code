import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/notice_tile/notice_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_notice_controller.dart';

class AdminNoticeView extends GetView<AdminNoticeController> {
  const AdminNoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Notice",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return NoticeTile(
                    noticeTitle: "Notice 101",
                    noticeDetails:
                        "saklajsdjaksjdklasjdklajsdjasdjklasjdklajssaklajsdjaksjdklasjdklajsdjasdjklasjdklajssaklajsdjaksjdklasjdklajsdjasdjklasjdklajssaklajsdjaksjdklasjdklajsdjasdjklasjdklajs",
                    noticeDate: "16-02-2023",
                    cardBackgroundColor: Colors.white,
                    onTap: () {
                      controller.showNoticeDetailsBottomSheet(
                        index: index,
                        bottomSheetBackgroundColor: Colors.white,
                      );
                    },
                  );
                },
              ),
              50.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
