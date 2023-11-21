import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/button/primary_button.dart';
import '../../../../utilities/widgets/common_widgets/custom_container_widget.dart';

class OtherDownloadsTile extends StatelessWidget {
  final String contentTitle;
  final String topic;
  final String? date;
  final Function()? onTap;

  const OtherDownloadsTile({
    super.key,
    required this.contentTitle,
    required this.topic,
    this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWidget(
          borderColor: const Color(0xFFEAE7F0),
          color: Colors.white,
          borderWidth: 1,
          requiredWidget: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainerWidget(
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xFFF2F0F6),
                      requiredWidget: Center(
                        child: Text(
                          contentTitle,
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Date: ",
                          style: AppTextStyle.blackFontSize14W400,
                        ),
                        Text(
                          date ?? "",
                          style: AppTextStyle.blackFontSize14W400,
                        ),
                      ],
                    )
                  ],
                ),
                10.verticalSpacing,
                Text(
                  topic,
                  style: AppTextStyle.syllabusFontSize16W500,
                ),
                20.verticalSpacing,
                PrimaryButton(
                  onTap: onTap,
                  title: "Download",
                ),
              ],
            ),
          )),
    );
  }
}
