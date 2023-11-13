import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat_search/views/widget/recent_search_tile.dart';
import 'package:flutter_single_getx_api_v2/app/modules/chat_search/views/widget/suggested_search_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/image_path.dart';
import '../controllers/chat_search_controller.dart';

class ChatSearchView extends GetView<ChatSearchController> {
  const ChatSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      appBar: const SizedBox(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
            child: Row(
              children: [
                10.horizontalSpacing,
                InkWell(
                  onTap: Get.back,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagePath.back),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF7118BF),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: const Color(0xFFFFFFFF).withOpacity(0.3),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF8335C8)),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF635976).withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      style: AppTextStyle.textStyle12WhiteW400,
                    ),
                  ),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 1) {

                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Blocked Users"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomBackground(
              customWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: AppColors.profileValueColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Recent Search",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF).withOpacity(0.7),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        15.verticalSpacing,
                        Flexible(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return RecentSearchTile(
                                profileImage: ImagePath.editProfileImage,
                                name: "Robben Bobb",
                                onTap: (){},
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 20.horizontalSpacing;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  30.verticalSpacing,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Suggested",
                      style: AppTextStyle.homeworkElements,
                    ),
                  ),
                  20.verticalSpacing,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SuggestedSearchTile(
                              profileImage: ImagePath.editProfileImage,
                              name: "Lionel Messi",
                              onTap: (){},
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
