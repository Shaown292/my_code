import 'package:flutter/material.dart';
import '../../../data/constants/app_colors.dart';
import 'custom_app_bar.dart';

class InfixEduScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final String schoolName;
  final bool? centerTitle;
  final Function() messengerOnTap;
  final Function() logoutOnTap;
  final Widget body;

  const InfixEduScaffold({
    Key? key,
    this.backgroundColor,
    required this.schoolName,
    this.centerTitle,
    required this.messengerOnTap,
    required this.logoutOnTap,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          messengerOnTap: messengerOnTap,
          logoutOnTap: logoutOnTap,
          schoolName: schoolName,
        ),
      ),
      body: body,
    );
  }
}
