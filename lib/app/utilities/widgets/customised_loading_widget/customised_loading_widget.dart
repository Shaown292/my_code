import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';

class SecondaryLoadingWidget extends StatelessWidget {
  const SecondaryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return    Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator(
        color: AppColors.primaryColor,
        radius: 24,
      )
          : const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          AppColors.activeStatusYellowColor,
        ),
      ),
    );
  }
}
