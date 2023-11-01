import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/notice/views/widget/notice_card.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/notice_controller.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Notice",
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CustomBackground(
          customWidget: RefreshIndicator(
            onRefresh: () async{
              controller.allNoticeList.clear();
              controller.getAllNoticeList();
            },
            child: Obx(()=>controller.loadingController.isLoading ? const LoadingWidget(): controller.allNoticeList.isNotEmpty ?
            ListView.builder(
                itemCount: controller.allNoticeList.length,
                itemBuilder: (context, index){
                  return  NoticeCard(
                    noticeTitle: controller.allNoticeList[index].noticeTitle,
                    noticeDetails: controller.allNoticeList[index].noticeMessage,
                    noticeDate:controller.allNoticeList[index].publishOn,
                    onTap: (){
                      controller.showNoticeDetailsBottomSheet(index: index);
                    },

                  );
                }) : const Center(child: NoDataAvailableWidget())),
          )
        ),
      ),
    );
  }
}
