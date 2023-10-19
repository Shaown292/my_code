import 'package:flutter/material.dart';

import '../../data/constants/app_dimens.dart';

ShapeBorder defaultBottomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        AppDimens.primaryRadius,
      ),
      topRight: Radius.circular(
        AppDimens.primaryRadius,
      ),
    ),
  );
}