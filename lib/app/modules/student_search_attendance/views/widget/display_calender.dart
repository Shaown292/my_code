import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DisplayCalender extends StatelessWidget {
  final EventList<Event>? eventList;
  final DateTime? currentDate;
  final Function(DateTime)? onCalendarChanged;

  const DisplayCalender({
    super.key,
    this.eventList,
    this.onCalendarChanged,
    this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color(0xFFF4EBFC),
                ],
              ),
              borderRadius: BorderRadius.circular(8)),
          child: CalendarCarousel<Event>(
            customDayBuilder: (
              /// you can provide your own build function to make custom day containers
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
              return null;
            },
            onCalendarChanged: onCalendarChanged,
            height: Get.height * 0.5,
            daysTextStyle: AppTextStyle.fontSize14GreyW400,
            todayTextStyle: AppTextStyle.fontSize14GreyW400,
            headerTextStyle: AppTextStyle.homeworkSubject,
            weekdayTextStyle: AppTextStyle.fontSize14GreyW400,
            weekDayPadding: EdgeInsets.zero,
            markedDatesMap: eventList,
            selectedDateTime: currentDate ?? DateTime.now(),
            weekendTextStyle: AppTextStyle.fontSize14GreyW400,
            selectedDayBorderColor: Colors.transparent,
            selectedDayButtonColor: Colors.white,
            thisMonthDayBorderColor: Colors.transparent,
            daysHaveCircularBorder: false,
            leftButtonIcon: const Icon(
              Icons.arrow_back_ios_new,
              size: 13,
              color: AppColors.editProfileTextFieldLabelColor,
            ),
            rightButtonIcon: const Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: AppColors.editProfileTextFieldLabelColor,
            ),
          ),
        ),
        10.verticalSpacing,
      ],
    );
  }
}
