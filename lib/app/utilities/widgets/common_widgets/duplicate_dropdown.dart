import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class DuplicateDropdown extends StatelessWidget {
  final dynamic dropdownValue;
  final List<dynamic>? dropdownList;
  final Function(dynamic v)? changeDropdownValue;
  final Color? color;
  final Color? dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;

  const DuplicateDropdown({
    super.key,
    this.dropdownValue,
    this.dropdownList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor,
    this.dropdownText = true,
    this.activeStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF635976).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            menuMaxHeight: Get.height * 0.4,
            isExpanded: true,
            items: dropdownList!
                .map(
                  (dynamic item) => DropdownMenuItem<dynamic>(

                value: item,
                child: dropdownText
                    ? Text(
                  item.name ?? "Unknown",
                  style: AppTextStyle.fontSize14lightBlackW400,
                  overflow: TextOverflow.ellipsis,
                )
                    : Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeStatusColor),
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
            iconSize: 26,
            dropdownColor: dropdownColor,
            iconEnabledColor: color ?? AppColors.profileValueColor,
            onChanged: changeDropdownValue,
          ),
        ),
      ),
    );
  }
}

