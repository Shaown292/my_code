import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/appbar/custom_appbar.dart';
import 'package:get/get.dart';

class InfixEduScaffold extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? body;
  final Widget? appBar;
  final List<Widget>? actions;

  const InfixEduScaffold({
    super.key,
    this.title,
    this.body,
    this.appBar,
    this.leadingIcon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundPrimaryColor,
              AppColors.backgroundSecondaryColor
            ]),
      ),
      height: Get.height,
      width: Get.width,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: appBar ??
              CustomAppBar(
                leadingIcon: leadingIcon,
                title: title,
                actions: actions,
              ),
        ),
        body: body,
      ),
    );
  }
}
