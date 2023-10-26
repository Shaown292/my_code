import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text_style.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import 'event_status.dart';

class DisplayCalender extends StatelessWidget {
  static final presentEvent = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    height: 5.0,
    width: 5.0,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF00C106),
    ),
  );

  static final Container halfDayEvent = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF5057FC),
    ),
    height: 5.0,
    width: 5.0,
  );

  static final lateEvent = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    height: 5.0,
    width: 5.0,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFFF6F00),
    ),
  );

  static final absentEvent = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    height: 5.0,
    width: 5.0,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFF32E21),
    ),
  );

  static final holidayEvent = Container(
    margin: const EdgeInsets.symmetric(horizontal: 1.0),
    height: 5.0,
    width: 5.0,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF462564),
    ),
  );

  EventList<Event> markedDateMap = EventList<Event> (
    events: {
      DateTime(2023, 10, 15): [
        Event(date: DateTime(2023, 1, 15), dot: presentEvent),
        Event(date: DateTime(2023, 1, 15), title: 'Event 1', dot: holidayEvent),
      ],
      DateTime(2023, 10, 16): [
        Event(date: DateTime(2023, 1, 15), title: 'Event 1', dot: halfDayEvent),
        Event(date: DateTime(2023, 1, 15), title: 'Event 3', dot: lateEvent),
        Event(date: DateTime(2023, 1, 15), title: 'Event 3', dot: absentEvent),
      ],
      DateTime(2023, 10, 31): [
        Event(date: DateTime(2023, 1, 15), title: 'Event 1', dot: halfDayEvent),
      ]
    },
  );

  DisplayCalender({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              weekendTextStyle: AppTextStyle.fontSize14GreyW400,
              thisMonthDayBorderColor: Colors.grey,
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
              height: Get.height * 0.5,
              todayButtonColor: Colors.white,
              daysTextStyle: AppTextStyle.fontSize14GreyW400,
              todayTextStyle: AppTextStyle.fontSize14GreyW400,
              // headerText: DateFormat('EEEE').format(DateTime.now()),
              headerTextStyle: AppTextStyle.homeworkSubject,
              weekdayTextStyle: AppTextStyle.fontSize14GreyW400,
              markedDatesMap: markedDateMap,

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

              // selectedDateTime: _currentDate,
              // markedDateShowIcon: true,
              // markedDateIconMaxShown: 1,
            ),
          ),
          10.verticalSpacing,
          const Column(
            children: [
              EventStatus(
                color: Color(0xFF00C106),
                title: "Present",
                numberOfDays: 3,
              ),
              EventStatus(
                color: Color(0xFF5057FC),
                title: "Halfday",
                numberOfDays: 3,
              ),
              EventStatus(
                color: Color(0xFFFF6F00),
                title: "Late",
                numberOfDays: 3,
              ),
              EventStatus(
                color: Color(0xFFF32E21),
                title: "Absent",
                numberOfDays: 3,
              ),
              EventStatus(
                color: Color(0xFF462564),
                title: "Holiday",
                numberOfDays: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
