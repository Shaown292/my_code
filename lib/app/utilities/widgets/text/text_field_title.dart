import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool required;

  const TextFieldTitle({
    required this.title,
    required this.required,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: AppColors.homeQuickLinkAddMoreBorderColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          ' *',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: required ? AppColors.requiredTextColor : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
