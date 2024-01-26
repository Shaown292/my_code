import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

class CustomDropdown extends StatelessWidget {
  final String? dropdownValue;
  final String? hint;
  final List<String>? dropdownList;
  final Function(String? v)? changeDropdownValue;
  final Color? color;
  final Color? dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;

  const CustomDropdown({
    super.key,
    this.dropdownValue,
    this.dropdownList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor,
    this.dropdownText = true,
    this.activeStatusColor, this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF635976).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(hint ?? ""),
            items: dropdownList!
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: dropdownText
                        ? Text(
                            item,
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
                                item,
                                style: AppTextStyle.cardTextStyle14WhiteW500,

                              ),
                            ],
                          ),
                  ),
                )
                .toList(),
            value: dropdownValue,
            iconSize: 26,
            dropdownColor: dropdownColor,
            iconEnabledColor: color ?? const Color(0xFF6B7280),
            onChanged: changeDropdownValue,
          ),
        ),
      ),
    );
  }
}
