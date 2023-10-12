import 'package:flutter/material.dart';
import '../../../data/constants/image_path.dart';


class PrimaryAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const PrimaryAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 66,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.appLogo),
                )),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
      actions: actions,
    );
  }
}
