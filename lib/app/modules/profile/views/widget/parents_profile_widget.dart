import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/parents_info.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';


import 'guardian_info.dart';



class ParentsProfileWidget extends StatelessWidget {
  const ParentsProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ParentsInfo(designation: 'Father', icon: ImagePath.parentsProfile, name: 'Md. Rofiku islam', phone: '+8845215555', occupation: 'Farmer'),
        20.verticalSpacing,
        ParentsInfo(designation: 'Mother', icon: ImagePath.parentsProfile, name: 'Mst. Fatema Khatun', phone: '+8845215555', occupation: 'Housewife'),
        20.verticalSpacing,
        GuardianInfo(  designation: 'Guardian', icon: ImagePath.parentsProfile, name: 'Salam molla', email: 'salam@gmail.com', phone: '0464794664', occupation: 'Farmer', relation: 'Brother', other: 'Other',)
      ],
    );
  }
}















