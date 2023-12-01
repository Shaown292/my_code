import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/result/views/widget/flexible_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexibleText(
                text: "Model",
              ),
              FlexibleText(
                text: "Number",
              ),
              FlexibleText(
                text: "Made Year",
              ),
              FlexibleText(
                text: "Note",
              ),
            ],
          ),
          10.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexibleText(
                text: model ?? "",
              ),
               FlexibleText(
                text: number ?? "",
              ),
              FlexibleText(
                text: madeYear ?? "",
              ),
              FlexibleText(
                text: note ?? "",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
