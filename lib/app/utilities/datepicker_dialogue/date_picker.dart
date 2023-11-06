import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerUtils {
  Future<DateTime?> pickDate({
    int additionalYear = 1,
  }) async {
    DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + additionalYear),
    );
    return dateTime;
  }
}
