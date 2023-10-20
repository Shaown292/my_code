


import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/modules/syllabus/views/widgets/syllabus_topic_wise.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/appbar/custom_appbar.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';

class SyllabusView extends GetView<GetxController>{
  const SyllabusView({super.key});

  @override
  Widget build(BuildContext context) {

    return InfixEduScaffold(
      title: "Syllabus",
      body: CustomBackground(
        customWidget: Column(
          children: [

            const SyllabusTopicWise(subject:  "Mathematics", topic: 'Trigonometry For Class Seven Final Part', date: "10 Nov 2023",),
            10.verticalSpacing,
            const SyllabusTopicWise(subject:  "Mathematics", topic: 'Trigonometry For Class Seven Final Part', date: "10 Nov 2023",),
            10.verticalSpacing,
            const SyllabusTopicWise(subject:  "Mathematics", topic: 'Trigonometry For Class Seven Final Part', date: "10 Nov 2023",),
            10.verticalSpacing,
            const SyllabusTopicWise(subject:  "Mathematics", topic: 'Trigonometry For Class Seven Final Part', date: "10 Nov 2023",),


          ],
        ),
      ),
    );
  }

}