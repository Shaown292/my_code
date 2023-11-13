import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

import '../../../../data/constants/app_colors.dart';

class SuggestedSearchTile extends StatelessWidget {
  final String? profileImage;
  final String? name;
  final Function()? onTap;

  const SuggestedSearchTile({
    super.key,
    this.profileImage,
    this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(profileImage ?? ""), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 10,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.activeStatusColor),
                  ), //Icon
                ),
              ], //<Widget>[]
            ),
            20.horizontalSpacing,
             Text(
              name ?? "",
              style: AppTextStyle.fontSize13BlackW400,
            )
          ],
        ),
      ),
    );
  }
}
