import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/button/primary_button.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_container_widget.dart';
import 'package:get/get.dart';


class SyllabusTopicWise extends StatelessWidget {

  final String contentTitle;
  final String topic;
  final String? date;
  final Function()? onTap;

  const SyllabusTopicWise(
      {super.key, required this.contentTitle, required this.topic, this.date, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWidget(
          borderColor: const Color(0xFFEAE7F0),
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
                      height: 30,
                      width: 100,
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
