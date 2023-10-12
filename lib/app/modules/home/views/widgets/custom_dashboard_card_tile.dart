import 'package:flutter/material.dart';

import 'custom_card_tile.dart';

class CustomDashboardTile extends StatefulWidget {

  final List<dynamic> listItems;
  const CustomDashboardTile({Key? key, required this.listItems}) : super(key: key);

  @override
  State<CustomDashboardTile> createState() => _CustomDashboardTileState();
}

class _CustomDashboardTileState extends State<CustomDashboardTile> {

  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, index) {

        return CustomCardTile(icon: widget.listItems[index].icon, title: widget.listItems[index].title, onTap: (){
          setState(() {
            selectIndex = index;
          });
        },isSelected: selectIndex == index,);

      },
    );
  }
}
