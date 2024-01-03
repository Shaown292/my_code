import 'package:flutter/material.dart';

class FeesPopupMenu extends StatelessWidget {
  final Function(int)? onTap;
  const FeesPopupMenu({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconColor: Colors.white,
      onSelected: onTap,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("View Invoice"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Add Payment"),
        ),

      ],
    );
  }
}
