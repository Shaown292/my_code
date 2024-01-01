import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class FilesPopupDialog extends StatelessWidget {
  final TabController? tabController;
  final int tabBarLength;
  final List<Widget>? tabs;
  final Function(int)? onTap;
  final int? numberOfImage ;
  final String? imageUrl;

  const FilesPopupDialog({
    super.key,
    this.tabController,
    required this.tabBarLength,
    this.tabs, this.onTap, this.numberOfImage, this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarLength,
      child: Column(
        children: [
          20.verticalSpacing,
          Row(
            children: [
              15.horizontalSpacing,
              InkWell(
                onTap: () => Get.back(),
                child: Image.asset(
                  ImagePath.back,
                  scale: 4,
                  color: Colors.black,
                ),
              ),
              30.horizontalSpacing,
              const Text(
                "Images and Files",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
            ],
          ),
          20.verticalSpacing,
          TabBar(
              labelColor: AppColors.profileValueColor,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
              indicatorColor: AppColors.profileIndicatorColor,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              tabs: tabs!,
              onTap : onTap,
          ),
          10.verticalSpacing,
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOfImage,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl ?? "")
                        )
                      ),
                    );
                  },
                ),
                Text("Data 2"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
