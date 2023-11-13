import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import 'event_status.dart';

class DisplayCalender extends StatelessWidget {
  final EventList<Event>? eventList;
  final Function(DateTime)? onCalendarChange;
  const DisplayCalender({super.key, this.eventList, this.onCalendarChange,});

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
            onCalendarChanged: onCalendarChange,
            // onLeftArrowPressed: onCalendarChange,

            height: Get.height * 0.5,
            todayButtonColor: Colors.transparent,
            todayBorderColor: Colors.transparent,
            daysTextStyle: AppTextStyle.fontSize14GreyW400,
            todayTextStyle: AppTextStyle.fontSize14GreyW400,
            headerTextStyle: AppTextStyle.homeworkSubject,
            weekdayTextStyle: AppTextStyle.fontSize14GreyW400,
            weekDayPadding: EdgeInsets.zero,
            markedDatesMap: eventList,
            selectedDateTime: DateTime.now(),
            selectedDayButtonColor: Colors.white,
            weekendTextStyle: AppTextStyle.fontSize14GreyW400,
            thisMonthDayBorderColor: Colors.grey,

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

