import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import '../../data/module_data/home_data/home_dummy_data.dart';


class AppFunctions {


   void getFunctions(int rule) {
    Route route;

    switch (rule) {
      case 1:
        GlobalVariableController.homeTileList = adminList;
        break;
      case 2:
        GlobalVariableController.homeTileList = studentList;
        // for(int i = 0; i < globalVariableController.homeTileList.length; i++){
        //   print(globalVariableController.homeTileList[i].value);
        // }
        break;
      case 3:
        GlobalVariableController.homeTileList = parentList;
        break;
      case 4:
        GlobalVariableController.homeTileList = teacherList;
        for(int i = 0; i < GlobalVariableController.homeTileList.length; i++){
          print(GlobalVariableController.homeTileList[i].icon);
        }
        break;
      case 5:
        GlobalVariableController.homeTileList = adminList;
        break;
      case 9:
        GlobalVariableController.homeTileList = adminList;
        print('driver::::::::::::::::');

        break;
    }
  }

}