import 'package:get/get.dart';

class AdminClassSetAttendanceController extends GetxController {

  RxBool isSelected = false.obs;
  final selectIndex = RxInt(0);
  RxString status = "P".obs;


  List <String> title = [
    "Present",
    "Absent",
    "Late",
    "Half Day"
  ];
  // RxList<AttendanceDataModel> attendanceList = <AttendanceDataModel>[
  //   AttendanceDataModel(
  //       id: "P",
  //       name: "Present"
  //   ),
  //   AttendanceDataModel(
  //       id: "A",
  //       name: "Absent"
  //   ),
  //   AttendanceDataModel(
  //       id: "L",
  //       name: "Late"
  //   ),
  //   AttendanceDataModel(
  //       id: "H",
  //       name: "Half day"
  //   )
  // ].obs;

}
//
// class AttendanceDataModel {
//
//   final String id;
//   final String name;
//   AttendanceDataModel({required this.id, required this.name});
//
// }



