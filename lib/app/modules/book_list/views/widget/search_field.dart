import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String searchKey)? onChange;
  final Function()? onTap;
  final bool isTextFieldEmpty;
  final Widget? icon;
  final TextStyle? hintTextStyle;
  final double? borderRadius;

  const SearchField({
    super.key,
    required this.controller,
    this.onChange,
    this.isTextFieldEmpty = false,
    this.onTap,
    this.icon,
    this.hintTextStyle, this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search".tr,
          hintStyle: hintTextStyle,
          suffixIcon: icon,
          filled: true,
          fillColor: const Color(0xFFF2F0F6),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
      controller: controller,
      onChanged: onChange,
      onSubmitted: _onSearchFieldChanged,
    );
  }

  _onSearchFieldChanged(String value) async {
    value = controller.text;
    debugPrint(controller.text);
  }
}
