// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';

// Package imports:

class PermissionCheck{

  Future<void> checkPermissions(BuildContext context) async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    print('Permission:::::::: $permissionStatus');
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    if (await Permission.storage.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      permissionsDenied(context);
    }
    if(await Permission.storage.isDenied){
      permissionsDenied(context);
    }if(await Permission.storage.isPermanentlyDenied){
      openAppSettings();
    }
  }

  void permissionsDenied(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Permission denied"),
            children: <Widget>[
              Container(
                padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: const Text(
                  "You must grant all permission to use this application",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            ],
          );
        });
  }
}