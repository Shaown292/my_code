import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatefulWidget {
  late String dropdownValue;
  final List<String>? scheduleList;
   CustomDropdown({
    super.key,
     required this.dropdownValue,
    this.scheduleList,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        items: widget.scheduleList!
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style:  AppTextStyle.fontSize14lightViolateW400,
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: widget.dropdownValue,
        onChanged: (String? value) {
          setState(() {
            widget.dropdownValue = value!;
          });
        },
        buttonStyleData:  ButtonStyleData(
          width: Get.width,

        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 16,
          iconEnabledColor: Color(0xFFA6ABCE),

        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,

        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,

        ),
      ),
    );
  }
}
