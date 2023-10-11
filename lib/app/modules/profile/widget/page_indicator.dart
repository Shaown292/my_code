
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_divider.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.isActive});
  final bool isActive ;

  @override
  Widget build(BuildContext context) {
    return  CustomDivider(
      width: 50,
      color: isActive ? AppColors.profileIndicatorColor : Colors.white,
    );
  }
}


