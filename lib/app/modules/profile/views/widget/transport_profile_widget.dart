import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class TransportProfileWidget extends StatelessWidget {


  const TransportProfileWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        transportWidget("Route", "Transport Route 97"),
        transportWidget("Vehicle Number", "INFIX-9700"),
        transportWidget("Driver Name", "Turner Bergnaum"),
        transportWidget("Driver Phone Number", "123456789"),
        transportWidget("Dormitory Name", "Sir Isaac Newton Hostel"),
      ],
    );
  }
}

Widget transportWidget ( String title, String value) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width/2,
            child: Text(
              title,
              style: const TextStyle(
                  color: AppColors.profileTitleColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
                color: AppColors.profileTitleColor,
                fontSize: 10,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
      10.verticalSpacing,
      CustomDivider(
        width: Get.width,
        color: AppColors.profileDividerColor,
      ),
      30.verticalSpacing,
    ],
  );
}


