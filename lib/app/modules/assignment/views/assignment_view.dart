import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/assignment/views/widget/assignment_card.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const InfixEduScaffold(
      title: "Assignment",
      body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                AssignmentCard(
                  assignmentTile:"Assignment Title is Here",
                  assignmentDetails: "An Assessment of the Impact of a Collaborative Didactic Approach and Students' Background in Teaching Computer Animation",
                    dueDate: "Nov 10",
                ),

              ],
            ),
          ),
      ),
    );
  }
}
