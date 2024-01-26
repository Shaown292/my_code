import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:get/get.dart';
import '../../../data/constants/image_path.dart';

class PrimaryAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const PrimaryAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor.withOpacity(0),
      elevation: 0,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 66,
                decoration: const BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage(ImagePath.appLogo),
                  ),
                ),
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
        ],
      ),
      actions: actions,
    );
  }
}
