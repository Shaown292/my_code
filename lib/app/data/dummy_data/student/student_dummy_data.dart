import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';

class StudentTileModelClass {
  final String icon;
  final String title;
  final String value;

  StudentTileModelClass({
    required this.icon,
    required this.title,
    required this.value,
  });
}

List<StudentTileModelClass> student = [
  StudentTileModelClass(icon: ImagePath.homeWork, title: 'HomeWork', value: 'HomeWork'),
  StudentTileModelClass(icon: ImagePath.studyMaterials, title: 'Study Materials', value: 'Study Materials'),
  StudentTileModelClass(icon: ImagePath.timeline, title: 'Timeline', value: 'Timeline'),
  StudentTileModelClass(icon: ImagePath.attendance, title: 'Attendance', value: 'Attendance'),
  StudentTileModelClass(icon: ImagePath.examination, title: 'Examination', value: 'Examination'),
  StudentTileModelClass(icon: ImagePath.onlineExam, title: 'Online Exam', value: 'Online Exam'),
  StudentTileModelClass(icon: ImagePath.leave, title: 'Leave', value: 'Leave'),
  StudentTileModelClass(icon: ImagePath.notice, title: 'Notice', value: 'Notice'),
  StudentTileModelClass(icon: ImagePath.subjects, title: 'Subjects', value: 'Subjects'),
  StudentTileModelClass(icon: ImagePath.teacher, title: 'Teacher', value: 'Teacher'),
  StudentTileModelClass(icon: ImagePath.library, title: 'Library', value: 'Library'),
  StudentTileModelClass(icon: ImagePath.transport, title: 'Transport', value: 'Transport'),
  StudentTileModelClass(icon: ImagePath.dormitory, title: 'Dormitory', value: 'Dormitory'),
  StudentTileModelClass(icon: ImagePath.settings, title: 'Settings', value: 'Settings'),
];
