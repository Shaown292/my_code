import 'package:edge_alerts/edge_alerts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/profile_ui_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/received_sms_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/student_record/student_record_response_model.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../database/auth_database.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {

  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();

  List<HomeTileModelClass> homeTileList = <HomeTileModelClass>[];

  late ProfileInfoModel profileInfoModel;
  final AuthDatabase _authDatabase = AuthDatabase.instance;
  final selectIndex = RxInt(-1);
  List<StudentRecord> studentRecordList = [];
  List<String> studentRecordDropdownList = [];
  List<int> studentRecordIdList = [];



  // void _getUserInfo() {
  //   profileInfoModel = _authDatabase.getUserInfo()!;
  // }

  Future<PostRequestResponseModel> logout() async {
    LoadingController loadingController = Get.find();
    try {


      final response = await BaseClient().postData(
        url: InfixApi.logout,
        header: GlobalVariable.header,
      );

      PostRequestResponseModel postRequestResponseModel = PostRequestResponseModel.fromJson(response);

      if(postRequestResponseModel.success == true){
        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);

        loadingController.isLoading = false;
      } else{
        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);
        showBasicSuccessSnackBar(message: postRequestResponseModel.message ?? AppText.somethingWentWrong,);

        loadingController.isLoading = false;
      }

    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    } finally {
      await _authDatabase.logOut();
      // globalRxVariableController.token.value = null;
      // globalRxVariableController.userId.value = null;
      // globalRxVariableController.roleId.value = null;
      //
      // globalRxVariableController.notificationCount.value = null;
      // globalRxVariableController.studentRecordId.value = null;
      // globalRxVariableController.email.value = null;
      // globalRxVariableController.studentId.value = null;
      // globalRxVariableController.parentId.value = null;
      // globalRxVariableController.staffId.value = null;
      // globalRxVariableController.isStudent.value = false;

      Get.offNamedUntil('/secondary-splash', (route) => false);
      // Get.offNamedUntil('/splash', (route) => false);

      loadingController.isLoading = false;
    }


    return PostRequestResponseModel();
  }

  void getStudentRecord({required int studentId}) async {
    try {
      final response = await BaseClient().getData(
          url: InfixApi.getStudentRecord(studentId: studentId),
          header: GlobalVariable.header);

      StudentRecordResponseModel studentRecordResponseModel =
          StudentRecordResponseModel.fromJson(response);
      if (studentRecordResponseModel.success) {
        globalRxVariableController.studentRecordId.value =
            studentRecordResponseModel.data.studentRecords.first.id;
        if (studentRecordResponseModel.data.studentRecords.isNotEmpty) {
          for (int i = 0;
              i < studentRecordResponseModel.data.studentRecords.length;
              i++) {
            studentRecordList
                .add(studentRecordResponseModel.data.studentRecords[i]);
            globalRxVariableController.studentRecordId.value = studentRecordResponseModel.data.studentRecords.first.id;
            studentRecordDropdownList.add(
                'Class ${studentRecordResponseModel.data.studentRecords[i].studentRecordClass} (${studentRecordResponseModel.data.studentRecords[i].section})');
            studentRecordIdList
                .add(studentRecordResponseModel.data.studentRecords[i].id);
          }
        }
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }


  //// Push Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  final RxString _notificationToken = ''.obs;



  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  notificationSubscription() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging.getToken().then((value) {

        _notificationToken.value = value ?? '';
        sendTokenToServer(_notificationToken.value ?? '');

    });
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground! ===> HOME.DART');
      // print("Notification Title : ${message.notification.title}");
      // print("Notification Body: ${message.notification.body}");
      // print('DATA: ${message.data.toString()}');

      final receivedSms = receivedSmsFromJson(message.data['message']);

      if (receivedSms.phoneNumber == null) {
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification}');
          if (isClosed) {
            

            edgeAlert(
              Get.context!,
              title: message.notification?.title ?? '',
              description: message.notification?.body ?? '',
              gravity: Gravity.top,
              backgroundColor: Colors.deepPurple,
              icon: Icons.notifications_active,
              duration: 5,
            );
          }

          RemoteNotification? notification = message.notification;

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification?.title,
              notification?.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('Got a message whilst in the onMessageOpenedApp!');
      // print("Notification Title : ${message.notification.title}");
      // print("Notification Body: ${message.notification.body}");
      // print('DATA: ${message.data.toString()}');
      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        if (isClosed) {
          edgeAlert(
            Get.context!,
            title: message.notification?.title ?? '',
            description: message.notification?.body ?? '',
            gravity: Gravity.top,
            backgroundColor: Colors.deepPurple,
            icon: Icons.notifications_active,
            duration: 5,
          );
        }
      }
    });
  }


  void sendTokenToServer(String token) async {

    try{

      final response = await http.get(
          Uri.parse(InfixApi.setToken(globalRxVariableController.userId.value.toString() ?? '', token)),
          headers: GlobalVariable.header);
      print('Firebase Token ::: $token');
      print('Body::: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('token updated : ${response.statusCode}');
      } else {
        showBasicFailedSnackBar(message: 'Something went wrong');
      }

    }catch(e, t){
      debugPrint('$e');
      debugPrint('$t');
    }


  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: const [],
      ),
    );
  }

  @override
  void onInit() {

    homeTileList = Get.arguments["homeListTile"];

    debugPrint(
        'Role ID: ${globalRxVariableController.roleId} :::: Record ID: ${globalRxVariableController.studentId}');
    if (globalRxVariableController.roleId.value == 2 ||
        globalRxVariableController.roleId.value == 3) {
      if (globalRxVariableController.isStudent.value) {
        if (globalRxVariableController.studentId.value != null) {
          getStudentRecord(
            studentId: globalRxVariableController.studentId.value!,
          );
        }
      }
    }




    /// Push Notification
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload.toString() ?? '');
      },
    );

    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title.toString())
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body.toString())
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {},
            )
          ],
        ),
      );
    });

    selectNotificationSubject.stream.listen((String payload) async {});
    notificationSubscription();




    super.onInit();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

}


class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification(
      {required this.id,
        required this.title,
        required this.body,
        required this.payload});
}