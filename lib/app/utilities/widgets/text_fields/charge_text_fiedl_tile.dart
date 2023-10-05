import 'package:aora_book/app/utilities/extensions/widget.extensions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_popup/info_popup.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';
import 'text_form_field_with_title.dart';

class ChargeTextFieldTile extends StatelessWidget {
  final String title;
  final bool info;
  final TextEditingController? controller;
  final String? message;
  final bool? readOnly;
  final ValueChanged<String>? onChanged;

  const ChargeTextFieldTile({
    required this.title,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.info = false,
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(
            AppDimens.padding6,
          ),
          strokeWidth: info ? 2 : 0,
          color: AppColors.homeQuickLinkBorderColor,
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: info
                    ? null
                    : Get.width -
                        ((Get.width / 3.4) + (AppDimens.padding20 * 4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (info)
                      Row(
                        children: [
                          AppDimens.padding14.horizontalSpacing,
                          InfoPopupWidget(
                            contentTitle: message ?? '',
                            arrowTheme: const InfoPopupArrowTheme(
                              color: Colors.black26,
                            ),
                            child: const Icon(
                              Icons.help_rounded,
                              color: Colors.black,
                            ),
                          ),
                          AppDimens.padding4.horizontalSpacing,
                        ],
                      ),
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      ' :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AppDimens.padding14.horizontalSpacing,
              SizedBox(
                width: Get.width / 3.4,
                child: TextFormFieldWithTitle(
                  hintText: '\$ 00.00',
                  required: true,
                  onChanged: onChanged,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  readOnly: readOnly ?? false,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
