import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class StaffTile extends StatelessWidget {
  final String? staffName;
  final String? staffPhoneNo;
  final String? staffAddress;
  final String? staffImage;
  final Function()? onTap;

  const StaffTile({
    super.key,
    this.staffName,
    this.staffPhoneNo,
    this.staffAddress,
    this.onTap,
    this.staffImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(staffImage ?? ""),
                    ),
                  ),
                ),
                20.horizontalSpacing,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name :  ${staffName ?? ""}"),
                    Text("Phone : ${staffAddress ?? ""}"),
                    Text("Address : ${staffPhoneNo ?? ""}"),
                  ],
                )
              ],
            ),
            10.verticalSpacing,
            CustomDivider(
              width: Get.width,
              color: AppColors.transportDividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
