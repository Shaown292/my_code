import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/api_urls.dart';

class SingleChatController extends GetxController {

  GlobalRxVariableController globalRxVariableController = Get.find();
  TextEditingController sendTextController = TextEditingController();



  Rx<File> singleChatPickImage       = File('').obs;
  RxBool singleChatSendLoader = false.obs;
  RxInt toUserId = 0.obs;


  Future<void> singleChatSend() async {
    try {
      singleChatSendLoader.value = true;

      debugPrint('${Uri.parse(InfixApi.sendSingleChat)}');
      final request =
      http.MultipartRequest('POST', Uri.parse(InfixApi.sendSingleChat));
      request.headers.addAll(GlobalVariable.header);

      if (singleChatPickImage.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'file_attach', singleChatPickImage.value.path));
      }

      request.fields['message'] = sendTextController.text;
      request.fields['from_id'] = globalRxVariableController.userId.value.toString();
      request.fields['to_id'] = toUserId.value.toString();


      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        singleChatSendLoader.value = false;
        sendTextController.clear();
        singleChatPickImage.value = File('');
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        singleChatSendLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      singleChatSendLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      singleChatSendLoader.value = false;
    }
  }
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      singleChatPickImage.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'canceled file selection');
      debugPrint("User canceled file selection");
    }
  }

  bool validation() {
    if (sendTextController.text.isEmpty && singleChatPickImage.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter something');
      return false;
    }
    return true;
  }

  List<String> dummyList = [
    "Hello",
    "Hi",
    "How are you? How are you? How are you? How are you? How are you? How are you? How are you?",
    "How are you? How are you? How are you? How are you? How are you? How are you? How are you?",
    "Fine"
  ];

  @override
  void onInit() {

    toUserId.value = Get.arguments['to_user_id'];
    super.onInit();
  }
}
