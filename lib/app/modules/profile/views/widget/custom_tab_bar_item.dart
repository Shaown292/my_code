import 'package:flutter/material.dart';
import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class CustomTabBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final TextStyle? textStyle;
  final Function() onTap;

  const CustomTabBarItem(
      {super.key, required this.title, required this.isActive, required this.onTap, this.textStyle,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: textStyle ?? const TextStyle(
                color: AppColors.profileCardBackgroundColor,
                fontSize: 10,
                fontWeight: FontWeight.w700),
          ),
          isActive ? const CustomDivider(
            width: 50,
            color: AppColors.profileIndicatorColor,
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
