import 'package:aora_book/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';

class RadioButtonWidget extends StatelessWidget {
  final String? title;
  final bool active;
  final Function()? onTap;

  const RadioButtonWidget({
    this.title,
    required this.active,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: 100.circularRadius,
              border: Border.all(
                width: active ? 7 : 1,
                color: active
                    ? AppColors.primaryColor
                    : AppColors.radioButtonDeActiveColor,
              ),
            ),
          ),
          if (title != null)
            Row(
              children: [
                AppDimens.padding10.horizontalSpacing,
                Text(
                  title ?? '',
                  style: const TextStyle(
                    color: AppColors.searchTextColor2,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
