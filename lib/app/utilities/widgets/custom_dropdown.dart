import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final String? dropdownValue;
  final List<String>? scheduleList;
  final Function(String? v)? changeDropdownValue;

  const CustomDropdown({
    super.key,
    this.dropdownValue,
    this.scheduleList,
    this.changeDropdownValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,

        items: scheduleList!
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyle.fontSize14lightViolateW400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),)
            .toList(),
        value: dropdownValue,
        iconSize: 16,
        iconEnabledColor: const Color(0xFFA6ABCE),
        onChanged:changeDropdownValue

      ),
    );
  }
}
