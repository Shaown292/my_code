import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';

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
  HomeTileModelClass(icon: ImagePath.homeWork, title: 'HomeWork', value: 'HomeWork'),
  HomeTileModelClass(icon: ImagePath.studyMaterials, title: 'Study Materials', value: 'Study Materials'),
  HomeTileModelClass(icon: ImagePath.timeline, title: 'Timeline', value: 'Timeline'),
  HomeTileModelClass(icon: ImagePath.attendance, title: 'Attendance', value: 'Attendance'),
  HomeTileModelClass(icon: ImagePath.examination, title: 'Examination', value: 'Examination'),
  HomeTileModelClass(icon: ImagePath.onlineExam, title: 'Online Exam', value: 'Online Exam'),
  HomeTileModelClass(icon: ImagePath.leave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(icon: ImagePath.notice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(icon: ImagePath.subjects, title: 'Subjects', value: 'Subjects'),
  HomeTileModelClass(icon: ImagePath.teacher, title: 'Teacher', value: 'Teacher'),
  HomeTileModelClass(icon: ImagePath.library, title: 'Library', value: 'Library'),
  HomeTileModelClass(icon: ImagePath.transport, title: 'Transport', value: 'Transport'),
  HomeTileModelClass(icon: ImagePath.dormitory, title: 'Dormitory', value: 'Dormitory'),
  HomeTileModelClass(icon: ImagePath.settings, title: 'Settings', value: 'Settings'),
];


List<HomeTileModelClass> parentList = [

  HomeTileModelClass(icon: ImagePath.attendance, title: 'Attendance', value: 'Attendance'),
  HomeTileModelClass(icon: ImagePath.examination, title: 'Examination', value: 'Examination'),
  HomeTileModelClass(icon: ImagePath.onlineExam, title: 'Online Exam', value: 'Online Exam'),
  HomeTileModelClass(icon: ImagePath.leave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(icon: ImagePath.notice, title: 'Notice', value: 'Notice'),

];


List<HomeTileModelClass> teacherList = [
  HomeTileModelClass(icon: ImagePath.homeWork, title: 'HomeWork', value: 'HomeWork'),
  HomeTileModelClass(icon: ImagePath.examination, title: 'Examination', value: 'Examination'),
  HomeTileModelClass(icon: ImagePath.onlineExam, title: 'Online Exam', value: 'Online Exam'),

];


List<HomeTileModelClass> adminList = [

  HomeTileModelClass(icon: ImagePath.leave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(icon: ImagePath.notice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(icon: ImagePath.subjects, title: 'Subjects', value: 'Subjects'),
  HomeTileModelClass(icon: ImagePath.teacher, title: 'Teacher', value: 'Teacher'),
  HomeTileModelClass(icon: ImagePath.library, title: 'Library', value: 'Library'),
  HomeTileModelClass(icon: ImagePath.transport, title: 'Transport', value: 'Transport'),
  HomeTileModelClass(icon: ImagePath.dormitory, title: 'Dormitory', value: 'Dormitory'),
  HomeTileModelClass(icon: ImagePath.settings, title: 'Settings', value: 'Settings'),
];



