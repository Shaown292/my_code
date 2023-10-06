import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const CustomDivider({Key? key, this.width, this.height, this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 110,
      height: height ?? 1,
      color: color ?? AppColors.dividerColor,
    );
  }
}
