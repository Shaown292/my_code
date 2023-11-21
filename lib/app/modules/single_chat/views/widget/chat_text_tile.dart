import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class ChatTextTile extends StatelessWidget {
  final int sendText;
  final String? text;
  final Color? color;
  final TextStyle? textStyle;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;

  const ChatTextTile({
    super.key,
    this.sendText = 0,
    this.text,
    this.color,
    this.textStyle,
    this.radiusBottomLeft,
    this.radiusBottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(30),
              topLeft: const Radius.circular(30),
              bottomLeft: Radius.circular(radiusBottomLeft ?? 0),
              bottomRight: Radius.circular(radiusBottomRight ?? 0),
            ),
            color: color),
        child: Text(
          text ?? "",
          style: textStyle,
        ),
      ),
    );
  }
}


