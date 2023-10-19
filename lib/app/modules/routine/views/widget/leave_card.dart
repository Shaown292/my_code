import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_text_style.dart';

class LeaveCard extends StatelessWidget {
  final String? startingTime;
  final String? endingTime;
  const LeaveCard({
    super.key,
    this.startingTime,
    this.endingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text (
                      "Lunch Break",
                      style: AppTextStyle.fontSize14VioletW600,
                    ),
                    5.verticalSpacing,
                    Text(
                      "$startingTime - $endingTime",
                      style: AppTextStyle.fontSize14GreyW400,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
