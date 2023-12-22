import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class StaffTile extends StatelessWidget {
  final String? staffName;
  final String? staffPhoneNo;
  final String? staffAddress;
  final String? staffImage;
  final Function()? onTap;
  final bool isImageEmpty;
  final String? imageUrl;

  const StaffTile({
    super.key,
    this.staffName,
    this.staffPhoneNo,
    this.staffAddress,
    this.onTap,
    this.staffImage,
    this.isImageEmpty = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                isImageEmpty
                    ? Container(
                        height: Get.height * 0.12,
                        width: Get.width * 0.18,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          child: CacheImageView(
                            height: Get.height * 0.12,
                            width: Get.width * 0.18,
                            url: imageUrl,
                            errorImageLocal: ImagePath.dp,
                          ),
                        ),
                      )
                    : Container(
                        height: Get.height * 0.12,
                        width: Get.width * 0.18,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.dp),
                          ),
                        ),
                      ),
                20.horizontalSpacing,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name :  ${staffName ?? AppText.noDataAvailable}"),
                    Text("Phone : ${staffAddress ?? AppText.noDataAvailable}"),
                    Text(
                        "Address : ${staffPhoneNo ?? AppText.noDataAvailable}"),
                  ],
                )
              ],
            ),
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
