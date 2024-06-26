import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';

class InternetController extends GetxController {
  RxBool internet = false.obs;

  @override
  void onInit() {
    super.onInit();
    internetConnection();
  }

  Future internetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet.value = true;
      }
    } on SocketException catch (_) {
      internet.value = false;
    }
  }
}

void internetConnectionChecker() {
  InternetController internetController = Get.find();
  const oneSec = Duration(seconds: 1);
  Timer.periodic(oneSec, (Timer t) {
    internetController.internetConnection();
  });
}
