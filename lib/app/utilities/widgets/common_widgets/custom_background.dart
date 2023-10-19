import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackground extends StatelessWidget {
  final Widget customWidget;
  final double? height;
  final double? width;

  const CustomBackground({
    super.key,
    required this.customWidget,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
      child: Container(
        height: height ?? Get.height,
        width: width ?? Get.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        child: customWidget,
      ),
    );
  }
}
