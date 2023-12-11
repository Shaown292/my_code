import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/notice_tile/notice_tile.dart';

import 'package:get/get.dart';

import '../controllers/te_notice_controller.dart';

class TeNoticeView extends GetView<TeNoticeController> {
  const TeNoticeView({super.key});
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Notice",
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return NoticeTile(
                      noticeTitle: "Title",
                      noticeDetails: "Details",
                      noticeDate: "21st December 2023",
                      cardBackgroundColor: Colors.white,
                      onTap: () {
                        controller.showNoticeDetailsBottomSheet(
                            index: index,
                            bottomSheetBackgroundColor:
                            Colors.white);
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
