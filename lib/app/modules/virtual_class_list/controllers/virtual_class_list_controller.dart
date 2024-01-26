// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/routes/app_pages.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/online_class/zoom/zoom_meeting_list_response_model.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class VirtualClassListController extends GetxController {
  GlobalRxVariableController globalRxVariableController =
  Get.find<GlobalRxVariableController>();

  RxList<MeetingList> meetingList = <MeetingList>[].obs;
  RxBool zoomMeetingLoader = false.obs;
  RxString onlineClass = "".obs;
  String url = "";

  /// Get Zoom Meeting List
  Future<ZoomMeetingListResponseModel> getZoomMeetingList() async {
    try {
      meetingList.clear();

      zoomMeetingLoader.value = true;
      final response = await BaseClient().getData(
        url: url,
        header: GlobalVariable.header,
      );

      ZoomMeetingListResponseModel zoomMeetingListResponseModel =
      ZoomMeetingListResponseModel.fromJson(response);

      if (zoomMeetingListResponseModel.success == true) {
        zoomMeetingLoader.value = false;
        if (zoomMeetingListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < zoomMeetingListResponseModel.data!.length; i++) {
            meetingList.add(zoomMeetingListResponseModel.data![i]);
          }
        }
      } else {
        zoomMeetingLoader.value = false;
        showBasicFailedSnackBar(
          message: zoomMeetingListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      zoomMeetingLoader.value = false;
    }

    return ZoomMeetingListResponseModel();
  }

  Future<void> openZoom(
      {required String meetingId, required String status}) async {
    if (status == "JOIN" || status == 'START') {
      final url = InfixApi.getJoinMeetingUrlApp(meetingID: meetingId);

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        final webUrl = InfixApi.getJoinMeetingUrlWeb(meetingID: meetingId);
        if (await canLaunch(webUrl)) {
          await launch(webUrl);
        } else {
          throw Exception('Could not launch $url');
        }
      }
    }
  }

  final jitsiMeet = JitsiMeet();

  void join({required String roomId}) async {
    var options = JitsiMeetConferenceOptions(
      room: roomId,
      serverURL: 'https://meet.jit.si/',
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
      },
      featureFlags: {"unsaferoomwarning.enabled": false},
      userInfo: JitsiMeetUserInfo(
        displayName: 'name',
        email: globalRxVariableController.email.value,
      ),
    );
    jitsiMeet.join(options);
  }







  // void join({required String roomId}) async {
  //
  //   try{
  //
  //     String serverUrl = (serverText.text.trim().isEmpty ? null : serverText.text) ?? '';
  //
  //     // Enable or disable any feature flag here
  //     // If feature flag are not provided, default values will be used
  //     // Full list of feature flags (and defaults) available in the README
  //     Map<FeatureFlagEnum, bool> featureFlags = {
  //       FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
  //     };
  //     if (!kIsWeb) {
  //       // Here is an example, disabling features for each platform
  //       if (Platform.isAndroid) {
  //         // Disable ConnectionService usage on Android to avoid issues (see README)
  //         featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
  //       } else if (Platform.isIOS) {
  //         // Disable PIP on iOS as it looks weird
  //         featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
  //       }
  //     }
  //     // Define meetings options here
  //     var options = JitsiMeetingOptions()
  //       ..room = roomText.text
  //       ..serverURL = 'https://meet.jit.si/'
  //       ..subject = subjectText.text
  //       ..userDisplayName = nameText.text
  //       ..userEmail = emailText.text
  //       ..audioOnly = isAudioOnly
  //       ..audioMuted = isAudioMuted
  //       ..videoMuted = isVideoMuted
  //       ..featureFlags.addAll(featureFlags);
  //     // ..webOptions = {
  //     //   "roomName": roomText.text,
  //     //   "width": "100%",
  //     //   "height": "100%",
  //     //   "enableWelcomePage": false,
  //     //   "chromeExtensionBanner": null,
  //     //   "userInfo": {"displayName": nameText.text}
  //     // };
  //
  //     debugPrint("EkoJitsiingOptions: $options");
  //     await EkoJitsi.joinMeeting(
  //       options,
  //       listener: EkoJitsiListener(onConferenceWillJoin: ({message}) {
  //         debugPrint("${options.room} will join with message: $message");
  //       }, onConferenceJoined: ({message}) {
  //         debugPrint("${options.room} joined with message: $message");
  //       }, onConferenceTerminated: ({message}) {
  //         debugPrint("${options.room} terminated with message: $message");
  //       }),
  //     );
  //
  //   } catch(e, t){
  //     debugPrint('$e');
  //     debugPrint('$t');
  //   }
  //
  // }

  void _detectingUrl(String status) {
    switch (status) {
      case 'jitsi':
        url = InfixApi.jitsiMeetingList;
        break;
      case 'zoom':
        url = InfixApi.zoomMeetingList;
        break;
      case 'big_blue_button':
        url = InfixApi.bigBlueButtonMeetingList;
        break;
      case 'google_meet':
        url = InfixApi.bigBlueButtonMeetingList;
        break;
    }
  }
  @override
  void onInit() {
    onlineClass.value = Get.arguments["online_class"];
    _detectingUrl(onlineClass.value);
    print(" online class ::::::: $url");
    getZoomMeetingList();
    super.onInit();
  }
}