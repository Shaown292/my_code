class AppConfig{

  static String domainName   = 'https://spondan.com/infixedu';
  static String imageBaseUrl = 'https://spondan.com/infixedu/';

  static String appName = "InfixEdu";

  static bool isDemo = false;


  static String getExtension(String url) {
    var parts = url.split("/");
    return parts[parts.length - 1];
  }

}