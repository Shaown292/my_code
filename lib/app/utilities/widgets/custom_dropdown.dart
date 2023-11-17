import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

class CustomDropdown extends StatelessWidget {
  final String? dropdownValue;
  final List<String>? scheduleList;
  final Function(String? v)? changeDropdownValue;
  final Color? color;
  final Color? dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;

  const CustomDropdown({
    super.key,
    this.dropdownValue,
    this.scheduleList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor,
    this.dropdownText = true, this.activeStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          isExpanded: true,
          items: scheduleList!
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: dropdownText  ? Text(
                    item,
                    style: AppTextStyle.fontSize14lightViolateW400,
                    overflow: TextOverflow.ellipsis,
                  ) : Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration:   BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeStatusColor ),
                      ),
                      10.horizontalSpacing,
                      Text(
                        item,
                        style:  AppTextStyle.cardTextStyle14WhiteW500,
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
          iconEnabledColor: color ?? const Color(0xFFA6ABCE),
          onChanged: changeDropdownValue),
    );
  }
}
