import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDeleteDialogue extends StatelessWidget {
  final String? title;
  final String subTitle;
  final String noText;
  final String yesText;
  final Function()? onYesTap;

  const AccountDeleteDialogue({
    this.onYesTap,
    Key? key,
    this.title,
    required this.subTitle,
    required this.noText,
    required this.yesText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text(noText.toUpperCase())),
        TextButton(onPressed: onYesTap, child: Text(yesText.toUpperCase())),
      ],
    );
  }
}
