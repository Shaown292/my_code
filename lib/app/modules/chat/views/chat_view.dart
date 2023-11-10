import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: controller.isSearching.value ? "" : "Chat",
        actions: [
          InkWell(
            onTap: () {
              controller.isSearching.value = true;
            },
            child: controller.isSearching.value == false
                ? const Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                : Expanded(
                  child: Container(
                      color: Colors.white,
                      child: const Text("Search"),
                    ),
                ),
          ),
          5.horizontalSpacing,
          const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
        body: const CustomBackground(
          customWidget: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
