import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/show_status_tile/show_status_tile.dart';

import 'package:get/get.dart';

import '../controllers/virtual_class_list_controller.dart';

class VirtualClassListView extends GetView<VirtualClassListController> {
  const VirtualClassListView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Virtual Class List".tr,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomBackground(
              customWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpacing,
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                          child: ShowStatusTile(
                            firstTitle: "Topic",
                            firstValue: "Discrete Mathematics",
                            secondTitle: "Meeting Id",
                            secondValue: "15215561",
                            thirdTitle: "Start Time",
                            thirdValue: "10:20 AM" ,
                            activeStatus: "Join",
                            activeStatusColor: Colors.green,
                            onStatusTap: (){
                              print("Joined a Meeting $index");
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
