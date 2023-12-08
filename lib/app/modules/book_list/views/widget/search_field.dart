import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String searchKey)? onChange;
  final Function()? onTap;
  final bool isTextFieldEmpty;
  final Widget? icon;
  final TextStyle? hintTextStyle;

  const SearchField({
    super.key,
    required this.controller,
    this.onChange,
    this.isTextFieldEmpty = false,
    this.onTap,
    this.icon,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          hintStyle: hintTextStyle,
          suffixIcon: icon,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20.0),
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
