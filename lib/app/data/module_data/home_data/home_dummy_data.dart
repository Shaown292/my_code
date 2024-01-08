import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:get/get.dart';

class HomeTileModelClass {
  final String icon;
  final String title;
  final String value;

  HomeTileModelClass({
    required this.icon,
    required this.title,
    required this.value,
  });
}

List<HomeTileModelClass> studentList = [
  HomeTileModelClass(
      icon: ImagePath.studentHomeWork, title: 'Homework'.tr, value: 'Homework'),
  HomeTileModelClass(
      icon: ImagePath.studentStudyMaterials,
      title: 'Study Materials'.tr,
      value: 'Study Materials'),
  HomeTileModelClass(
      icon: ImagePath.studentAttendance,
      title: 'Attendance'.tr,
      value: 'Attendance'),
  HomeTileModelClass(
      icon: ImagePath.studentWallet, title: 'Wallet'.tr, value: 'Wallet'),
  HomeTileModelClass(
      icon: ImagePath.studentExamination,
      title: 'Examination'.tr,
      value: 'Examination'),
  HomeTileModelClass(
      icon: ImagePath.studentOnlineExam,
      title: 'Online Exam'.tr,
      value: 'Online Exam'),
  HomeTileModelClass(
      icon: ImagePath.studentLesson, title: 'Lesson'.tr, value: 'Lesson'),
  HomeTileModelClass(
      icon: ImagePath.studentLeave, title: 'Leave'.tr, value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.studentNotice, title: 'Notice'.tr, value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.studentSubjects, title: 'Subjects'.tr, value: 'Subjects'),
  HomeTileModelClass(
      icon: ImagePath.studentTeacher, title: 'Teacher'.tr, value: 'Teacher'),
  HomeTileModelClass(
      icon: ImagePath.studentLibrary, title: 'Library'.tr, value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.studentTransport, title: 'Transport'.tr, value: 'Transport'),
  HomeTileModelClass(
      icon: ImagePath.studentDormitory, title: 'Dormitory'.tr, value: 'Dormitory'),
  HomeTileModelClass(
      icon: ImagePath.studentClass, title: 'Class'.tr, value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.studentSettings, title: 'Settings'.tr, value: 'Settings'),
];

List<HomeTileModelClass> parentList = [
  HomeTileModelClass(
      icon: ImagePath.parentsChild, title: 'Child', value: 'Child'),
  HomeTileModelClass(
      icon: ImagePath.parentsAbout, title: 'About', value: 'About'),
  HomeTileModelClass(
      icon: ImagePath.parentsSettings, title: 'Settings', value: 'Settings'),
];

List<HomeTileModelClass> teacherList = [
  HomeTileModelClass(
      icon: ImagePath.teacherStudents, title: 'Students', value: 'Students'),
  HomeTileModelClass(
      icon: ImagePath.teacherLeave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.teacherContents, title: 'Content', value: 'Content'),
  HomeTileModelClass(
      icon: ImagePath.teacherNotice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.teacherLibrary, title: 'Library', value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.teacherAbout, title: 'About', value: 'About'),
  HomeTileModelClass(
      icon: ImagePath.teacherClass, title: 'Class', value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.teacherSettings, title: 'Settings', value: 'Settings'),
];

List<HomeTileModelClass> adminList = [
  HomeTileModelClass(
      icon: ImagePath.adminStudents, title: 'Students', value: 'Students'),
  HomeTileModelClass(
      icon: ImagePath.adminLeave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.adminStaff, title: 'Staff', value: 'Staff'),
  HomeTileModelClass(
      icon: ImagePath.adminDormitory, title: 'Dormitory', value: 'Dormitory'),
  HomeTileModelClass(
      icon: ImagePath.adminClassAttendance,
      title: 'Attendance',
      value: 'Attendance'),
  HomeTileModelClass(icon: ImagePath.adminFees, title: 'Fees', value: 'Fees'),
  HomeTileModelClass(
      icon: ImagePath.adminContent, title: 'Content', value: 'Content'),
  HomeTileModelClass(
      icon: ImagePath.adminNotice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.adminLibrary, title: 'Library', value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.adminTransport, title: 'Transport', value: 'Transport'),
  HomeTileModelClass(
      icon: ImagePath.adminClass, title: 'Class', value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.adminSettings, title: 'Settings', value: 'Settings'),
];


