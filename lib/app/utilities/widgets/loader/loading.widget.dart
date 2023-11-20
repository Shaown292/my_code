import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:get/get.dart';

import 'loading.controller.dart';
import 'dart:io' show Platform;

class LoadingWidget extends GetWidget<LoadingController> {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading
          ? Expanded(
            child: PopScope(
                    onPopInvoked: (bool value) => Future.value(false),
                child: Stack(
                  children: <Widget>[
                    ModalBarrier(
                      dismissible: false,
                      color: Colors.grey.withOpacity(.25),
                    ),
                    Center(
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              color: AppColors.primaryColor,
                              radius: 24,
                            )
                          : const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryColor,
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
