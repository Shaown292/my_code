import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';

// ignore: must_be_immutable
class SearchFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  String? initialValue;
  FocusNode? focusNode;
  FocusNode? nextNode;
  TextInputType? keyboardType;
  TextStyle? style;
  bool autofocus = false;
  AutovalidateMode? autovalidateMode;
  bool readOnly = false;
  bool obscureText = false;
  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  VoidCallback? onEditingComplete;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;
  FormFieldValidator<String>? validator;
  bool? enabled;
  Color? cursorColor;
  TextCapitalization textCapitalization;

  SearchFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.autovalidateMode,
    this.focusNode,
    this.nextNode,
    this.initialValue,
    this.keyboardType,
    this.style,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.cursorColor,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: keyboardType,
      style: style,
      autofocus: autofocus,
      readOnly: readOnly,
      obscureText: obscureText,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      textCapitalization: textCapitalization,
      onFieldSubmitted: (v) {
        focusNode?.unfocus();
        nextNode?.requestFocus();
        onFieldSubmitted?.call(v);
      },
      onSaved: onSaved,
      validator: validator,
      enabled: enabled,
      cursorColor: cursorColor,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.primaryPadding,
        ),
        counterStyle: const TextStyle(
          color: AppColors.textTextFieldColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: AppColors.hintTextFieldColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
