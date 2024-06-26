import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DuplicateDropdown extends StatelessWidget {
  final dynamic dropdownValue;
  final List<dynamic>? dropdownList;
  final Function(dynamic v)? changeDropdownValue;
  final Color? color;
  final Color? dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;
  final String? hint;
  final TextStyle? textStyle;
  final bool isChat;
  final EdgeInsets? padding;
  final double? sidePadding;
  final double? borderRadius;

  const DuplicateDropdown({
    super.key,
    this.dropdownValue,
    this.dropdownList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor,
    this.dropdownText = true,
    this.activeStatusColor,
    this.hint,
    this.textStyle,
    this.isChat = false,
    this.padding,
    this.borderRadius, this.sidePadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: sidePadding ?? 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: Border.all(
          color: const Color(0xFF635976).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(6.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            hint: Text(
              hint ?? "",
              style: AppTextStyle.fontSize13BlackW400,
            ),
            menuMaxHeight: Get.height * 0.4,
            isExpanded: true,
            items: dropdownList!
                .map(
                  (dynamic item) => DropdownMenuItem<dynamic>(
                    value: item,
                    child: dropdownText
                        ? Text(
                            item.name ?? "Unknown",
                            style: textStyle ??
                                AppTextStyle.dropdownText,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(item.statusColor)),
                              ),
                              10.horizontalSpacing,
                              Text(
                                item.name!,
                                style: AppTextStyle.cardTextStyle14WhiteW500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                  ),
                )
                .toList(),
            value: dropdownValue,
            // iconSize: 26,
            dropdownColor: dropdownColor,
            iconEnabledColor: color ?? const Color(0xFF6B7280),
            onChanged: changeDropdownValue,
          ),
        ),
      ),
    );
  }
}
