import 'package:flutter/material.dart';

class ChatTextTile extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextStyle? textStyle;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final double? textLeftPadding;
  final double? textRightPadding;
  final String? imageUrl;

  const ChatTextTile({
    super.key,
    this.text,
    this.color,
    this.textStyle,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.textLeftPadding,
    this.textRightPadding,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10,
          left: textLeftPadding ?? 0,
          right: textRightPadding ?? 0),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(20),
              topLeft: const Radius.circular(20),
              bottomLeft: Radius.circular(radiusBottomLeft ?? 0),
              bottomRight: Radius.circular(radiusBottomRight ?? 0),
            ),
            color: color),
        child: Column(
          children: [
            Text(
              text ?? "",
              style: textStyle,
            ),
            imageUrl == "" || imageUrl == null ?
            const SizedBox() :
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl!,)
                  )
              ),
            )
          ],
        )  ,
      ),
    );
  }
}
