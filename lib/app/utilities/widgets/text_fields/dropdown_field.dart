import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import 'dropdown_button_new.dart';

class DropdownField extends StatefulWidget {
  final List<String> genderItems;
  final Function(String? v)? onChanged;
  final String hint;
  final String? value;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Color? backgroundColor;

  const DropdownField({
    required this.genderItems,
    required this.onChanged,
    required this.hint,
    this.focusNode,
    this.nextNode,
    this.value,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  bool collapse = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DropdownButtonFormFieldNew(
          focusNode: widget.focusNode,
          value: widget.value,
          isExpanded: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 3,
                color: widget.backgroundColor ?? AppColors.textFieldBackgroundColor
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: widget.backgroundColor ?? AppColors.textFieldBackgroundColor
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 3,
                color: widget.backgroundColor ?? AppColors.textFieldBackgroundColor
              ),
            ),
            fillColor: widget.backgroundColor ?? AppColors.textFieldBackgroundColor,
            filled: true,
          ),
          // isExpanded: true,
          hint: Text(
            widget.hint,
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.hintTextFieldColor,
            ),
          ),
          // icon: const ,
          icon: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(
              collapse ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
              color: AppColors.homeQuickLinkAddMoreBorderColor,
              // size: 22,
            ),
          ),
          // iconSize: 30,
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          items: widget.genderItems
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null) {
              //return 'Please select gender.';
            }
          },
          onChanged: (v) {
            widget.focusNode?.unfocus();
            widget.nextNode?.requestFocus();
            widget.onChanged?.call(v.toString());
          },
          onSaved: (value) {},
          onMenuStateChange: (v) {
            setState(() {
              collapse = v;
            });
          }),
    );
  }
}
