import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/no_internet/internet_controller.dart';
import 'package:flutter_single_getx_api_v2/config/app_config.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/config/language/controller/language_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/database/auth_database.dart';
import 'app/utilities/widgets/loader/loading.controller.dart';
import 'config.dart';

class Initializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _initGlobalLoading();
    _getStoredLanguage();
    _initRotation();
    _initBinding();
    await _initStorage();
    _initGetConnect();

  }

  /// global loader
  static void _initGlobalLoading() {
    final loading = LoadingController();
    Get.put(loading);

    final  internetController             = InternetController();
    Get.put(internetController);

    final globalVariableGetx = GlobalRxVariableController();
    Get.put(globalVariableGetx);

    final languageController = LanguageController();
    Get.put(languageController);

  }

  static void _getStoredLanguage() async {
    LanguageController languageController = Get.find();
    final sharedPref = await SharedPreferences.getInstance();
    languageController.langName.value = sharedPref.getString('language_name') ?? 'English';
    language = sharedPref.getString('language') ?? 'en_US';
    Get.updateLocale(Locale(languageController.appLocale));

    debugPrint('::::::::::::::::: $language');
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
    String? baseUrl = AppConfig.domainName;

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
