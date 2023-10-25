import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/other_downloads/views/widget/other_downloads_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/other_downloads_controller.dart';

class OtherDownloadsView extends GetView<OtherDownloadsController> {
  const OtherDownloadsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Other Downloads",
      body: CustomBackground(
          customWidget: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const OtherDownloadsTile(
                  contentTitle: "contentTitle",
                  topic: "topic",
                );
              })),
    );
  }
}
