import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:get/get.dart';

class StudentListTile extends StatelessWidget {
  final bool isPhotoAvailable;
  final String? imageURL;
  final String? studentName;
  final String? studentClass;
  final String? studentSection;
  final List<dynamic>? classSectionList;
  final Function()? onTap;

  const StudentListTile({
    super.key,
    this.isPhotoAvailable = false,
    this.imageURL,
    this.studentName,
    this.studentClass,
    this.studentSection,
    this.classSectionList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isPhotoAvailable
                    ? Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.dp),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 70,
                        width: 70,

                        child: CacheImageView(
                          url: '${AppConfig.imageBaseUrl}$imageURL',
                          errorImageLocal: ImagePath.dp,
                        ),
                      ),
                10.horizontalSpacing,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName ?? AppText.noDataAvailable,
                      style: AppTextStyle.fontSize14lightBlackW400,
                    ),
                    3.verticalSpacing,
                    Row(
                      children: [
                        Text(
                          classSectionList!
                              .map((e) => e.classSection.toString())
                              .join(', '),
                        ),
                      ],
                    )
                  ],
                ),
                10.horizontalSpacing,
              ],
            ),
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.dormitoryDividerColor,
        ),
      ],
    );
  }
}
