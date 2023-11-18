import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DocumentsCard extends StatelessWidget {
  final String? title;
  final String? fileName;
  final Function()? tapDownload;
  final Function()? tapDelete;
  final Color? color;

  const DocumentsCard({
    super.key,
    this.title,
    this.fileName,
    this.tapDownload,
    this.tapDelete,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.parentsCardBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: AppTextStyle.syllabusFontSize16W500,
                    ),
                    5.verticalSpacing,
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Text(
                        fileName ?? "",
                        style: AppTextStyle.blackFontSize12W400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: tapDownload,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.appButtonColor),
                        child: Center(
                          child: Image.asset(
                            ImagePath.download,
                          ),
                        ),
                      ),
                    ),
                    7.horizontalSpacing,
                    InkWell(
                      onTap: tapDelete,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFED3B3B),
                        ),
                        child: Center(
                          child: Image.asset(
                            ImagePath.delete,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
