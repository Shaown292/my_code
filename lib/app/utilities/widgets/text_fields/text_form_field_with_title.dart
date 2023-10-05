import 'package:aora_book/app/utilities/widgets/text/text_field_title.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';
import '../../extensions/widget.extensions.dart';

// ignore: must_be_immutable
class TextFormFieldWithTitle extends StatelessWidget {
  final String? title;
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
  final Function()? onTap;
  VoidCallback? onEditingComplete;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;
  FormFieldValidator<String>? validator;
  Color? cursorColor;
  TextCapitalization textCapitalization;
  final bool required;
  final bool clickable;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Widget? prefix;

  TextFormFieldWithTitle({
    Key? key,
    this.title,
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
    this.cursorColor,
    this.textCapitalization = TextCapitalization.none,
    this.required = false,
    this.clickable = false,
    this.suffixIcon,
    this.backgroundColor,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldTitle(title: title ?? '', required: required),
              AppDimens.padding8.verticalSpacing,
            ],
          ),
        ),
        InkWell(
          onTap: clickable ? onTap : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppDimens.radius8.circularRadius,
              color: backgroundColor ?? AppColors.textFieldBackgroundColor,
            ),
            alignment: Alignment.centerLeft,
            child: IgnorePointer(
              ignoring: clickable,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      textAlign: TextAlign.start,
                      focusNode: focusNode,
                      initialValue: initialValue,
                      keyboardType: keyboardType,
                      style: style,
                      autofocus: autofocus,
                      readOnly: readOnly,
                      obscureText: obscureText,
                      onChanged: onChanged,
                      onEditingComplete: onEditingComplete,
                      textCapitalization: textCapitalization,
                      onTap: clickable?null:onTap,
                      onFieldSubmitted: (v) {
                        focusNode?.unfocus();
                        nextNode?.requestFocus();
                        onFieldSubmitted?.call(v);
                      },
                      onSaved: onSaved,
                      validator: validator,
                      // enabled: !clickable,
                      cursorColor: cursorColor,
                      autovalidateMode: autovalidateMode,
                      decoration: InputDecoration(
                        prefix: prefix,
                        hintText: hintText,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.primaryPadding,
                        ),
                        hintStyle: const TextStyle(
                          color: AppColors.searchTextColor2,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // suffixIcon: suffixIcon,
                      ),
                    ),
                  ),
                  suffixIcon ?? const SizedBox(),
                  if (suffixIcon != null) AppDimens.padding14.horizontalSpacing,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
