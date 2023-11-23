import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/dormitory_card_tile/dormitory_card_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_room_list_controller.dart';

class AdminRoomListView extends GetView<AdminRoomListController> {
  const AdminRoomListView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Room",
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return const DormitoryCardTile(
                    dormitoryName: "Sir Isaac Newton",
                    roomNo: "123",
                    cost: 210,
                    numberOfBed: 2,
                    roomType: "Single",
                    isAdminRoomList: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
