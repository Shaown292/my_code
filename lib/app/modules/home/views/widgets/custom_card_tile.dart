import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_dimens.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class CustomCardTile extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final Function() onTap;

  const CustomCardTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(AppDimens.padding12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: AppColors.boxBorderColor,
              ),
              borderRadius: BorderRadius.circular(AppDimens.radius5),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 74,
                  height: 74,
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: ShapeDecoration(
                      color:
                      isSelected ? Colors.white : AppColors.smallCardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radius3),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        icon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                10.verticalSpacing,
                const CustomDivider(
                  height: 1,
                  width: 110,
                ),
                10.verticalSpacing,
                Text(
                  title.toUpperCase(),
                  style: isSelected
                      ? AppTextStyle.cardTextStyle14WhiteW500
                      : AppTextStyle.cardTextStyle14PurpleW500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

