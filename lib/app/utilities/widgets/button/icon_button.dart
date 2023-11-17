import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Function()? onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size ?? 25,
      ),
    );
  }
}
