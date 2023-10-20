import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class WeekTabBarItem extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? textStyle;

  const WeekTabBarItem({
    required this.title,
    this.textStyle,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
