import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

class SelectingMember extends StatelessWidget {
  final TextEditingController searchTextController;
  final Function(String) onChange;
  final Function()? backOnTap;
  final String? iconData;
  final Function()? onAddButtonTap;
  final TextStyle? textStyle;

  const SelectingMember({
    super.key,
    required this.searchTextController,
    this.iconData,
    required this.onChange,
    this.onAddButtonTap, this.textStyle, this.backOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpacing,
        Row(
          children: [
            30.horizontalSpacing,
            InkWell(
              onTap: backOnTap,
              child: Image.asset(
                ImagePath.back,
                scale: 4,
                color: Colors.black,
              ),
            ),
            10.horizontalSpacing,
            const Text(
              "Add People",
              style: AppTextStyle.fontSize16lightBlackW500,
            ),
            const Spacer(),
            InkWell(
              onTap: onAddButtonTap,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add",
                  style: textStyle,
                ),
              ),
            ),
            20.horizontalSpacing,
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          child: TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: AppTextStyle.fontSize13BlackW400,
              // suffixIcon: searchTextController.text.isNotEmpty
              //     ? InkWell(
              //   onTap: () {
              //     controller.searchController.clear();
              //     controller.searchChatDataList.clear();
              //   },
              //   child: Icon(
              //     Icons.close,
              //     color: AppColors.profileDividerColor,
              //     size: 20,
              //   ),
              // )
              //     : Icon(
              //   Icons.search,
              //   color:
              //   const Color(0xFFFFFFFF).withOpacity(0.3),
              //   size: 20,
              // ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onChanged: onChange,
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
      ],
    );
  }
}
