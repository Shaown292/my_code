import 'package:flutter/material.dart';

class ShowWeekTile extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? textStyle;

  const ShowWeekTile({
    super.key,
    required this.title,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
            color: color,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
