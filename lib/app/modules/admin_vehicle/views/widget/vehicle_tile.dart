import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/result/views/widget/flexible_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class VehicleTile extends StatelessWidget {
  final String? model;
  final String? madeYear;
  final String? number;
  final String? note;
  final Color? color;

  const VehicleTile({
    super.key,
    this.model,
    this.madeYear,
    this.number,
    this.note,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             ColumnTile(
               title: "Model",
               value: model,
               width: Get.width * 0.2,
             ),
              ColumnTile(
                title: "Number",
                value: number,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Made Year",
                value: madeYear,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Note",
                value: note,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
