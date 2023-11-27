import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerUtils {
  Future<DateTime?> pickDate({
    int additionalYear = 1,
    bool canSelectPastDate = false,
  }) async {
    DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: canSelectPastDate ? DateTime(DateTime.now().year - additionalYear) :DateTime.now(),
      lastDate: canSelectPastDate ? DateTime.now() : DateTime(DateTime.now().year + additionalYear),
    );
    return dateTime;
  }
}
