import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTextTile extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextStyle? textStyle;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final double? textLeftPadding;
  final double? textRightPadding;
  final String? imageUrl;
  final Function()? onImageTap;

  const ChatTextTile({
    super.key,
    this.text,
    this.color,
    this.textStyle,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.textLeftPadding,
    this.textRightPadding,
    this.imageUrl, this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return text == "" && imageUrl!.isNotEmpty
        ? InkWell(
      onTap: onImageTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: Get.height * 0.3,
          width: Get.width * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imageUrl!,
              ),
            ),
          ),
        ),
      ),
    )
        :
    Padding(
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
            imageUrl == null || imageUrl!.isEmpty
                ? const SizedBox()
                : Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                onTap: onImageTap,
                child: Container(
                  height: Get.height * 0.15,
                  width: Get.width * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        imageUrl!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              text ?? "",
              style: textStyle,
            ),
          ],
        ),

      ),
    );
  }
}
