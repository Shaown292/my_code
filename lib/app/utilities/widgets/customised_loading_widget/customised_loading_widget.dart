import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';

class SecondaryLoadingWidget extends StatelessWidget {
  final bool isBottomNav;

  const SecondaryLoadingWidget({
    super.key,
    this.isBottomNav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBottomNav ? 65 : 100,
      margin:  EdgeInsets.symmetric(horizontal: isBottomNav ? 10 : 0),
      padding:  EdgeInsets.symmetric(vertical: isBottomNav ? 10 : 0, horizontal: isBottomNav ? 10 : 0),
      color: isBottomNav ? Colors.white : Colors.transparent,
      child: Center(
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
      ),
    );
  }
}
