import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class ParentsItemWidget extends StatelessWidget {
  const ParentsItemWidget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  const TextStyle(
              color: AppColors.profileTitleColor,
              fontSize: 10,
              fontWeight: FontWeight.w500),
        ),
        10.verticalSpacing,
        CustomDivider(
            color: AppColors.profileDividerColor,
            width: Get.width * 0.63
        ),
      ],
    );
  }
}
