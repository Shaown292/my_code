import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SingleChatController extends GetxController {

  TextEditingController sendTextController = TextEditingController();

  Rx<File> singleChatPickedImage       = File('').obs;
}
