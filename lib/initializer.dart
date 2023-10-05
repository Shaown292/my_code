import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/database/auth_database.dart';
import 'app/utilities/widgets/loader/loading.controller.dart';
import 'config.dart';

class Initializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _initRotation();
    _initBinding();
    await _initStorage();
    _initGetConnect();
    _initGlobalLoading();
  }

  /// global loader
  static void _initGlobalLoading() {
    final loading = LoadingController();
    Get.put(loading);
  }

  /// http client
  static Future<void> _initGetConnect() async {
    final connect = GetConnect();
    final fcm = GetConnect();
    Get.put(
      fcm,
      tag: 'fcm',
    );

    AuthDatabase authDatabase = AuthDatabase.instance;

    String? url;
    String? baseUrl = authDatabase.getUserInfo()?.organization.domain;

    if (baseUrl == null) {
      url = ConfigEnvironments.getEnvironments()['url'] ?? '';
    } else {
      url = ConfigEnvironments.getEnvironments()['url'] ?? '';
      // url = 'https://$baseUrl.salesmaster.pixelcoder.net/';
    }

    // url = baseUrl ?? ConfigEnvironments.getEnvironments()['url'] ?? '';
    debugPrint('base url is :=> $url');
    connect.baseUrl = url;
    connect.timeout = const Duration(seconds: 30);
    connect.httpClient.maxAuthRetries = 0;
    connect.httpClient.addRequestModifier<dynamic>(
      (request) {
        final token = AuthDatabase.instance.getToken();
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }

        return request;
      },
    );

    connect.httpClient.addResponseModifier(
      (request, response) async {
        debugPrint('request to:=> ${request.url}');

        if (response.statusCode == 401) {
          // AuthDatabase.instance.logOut();
          debugPrint('logout => clear local database data');
        }

        return response;
      },
    );
    Get.put(connect);
  }

  /// local storage
  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());

    await GetStorage.init(AuthDBKeys.dbName);
  }

  /// initialBindings
  static void _initBinding() {}

  static void _initRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
