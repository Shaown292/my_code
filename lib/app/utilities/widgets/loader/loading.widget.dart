import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading.controller.dart';
import 'dart:io' show Platform;

class LoadingWidget extends GetWidget<LoadingController> {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading
          ? WillPopScope(
              onWillPop: () => Future.value(false),
              child: SizedBox(
                height: Get.height,
                child: Stack(
                  children: <Widget>[
                    ModalBarrier(
                      dismissible: false,
                      color: Colors.grey.withOpacity(.25),
                    ),
                    Center(
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              color: Colors.redAccent,
                              radius: 24,
                            )
                          : const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Colors.redAccent,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox();
    });
  }
}
