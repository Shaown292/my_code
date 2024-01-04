class AppConfig{

  static String domainName   = 'https://spondan.com/infixedu';
  static String imageBaseUrl = 'https://spondan.com/infixedu/';

  static String appName = "InfixEdu";

  static bool isDemo = false;


  static String getExtension(String url) {
    var parts = url.split("/");
    return parts[parts.length - 1];
  }

  /// Stripe Payment Gateway
  static const String stripeServerURL =
      'https://api.stripe.com/v1/payment_intents';
  static const String stripeCurrency = "USD";
  static const String stripeMerchantID = "merchant.thegreatestmarkeplace";
  static const String stripePublishableKey =
      "pk_test_51JAWNlKS0igSTFP16dhgcM1fBayh6DStrpu5OA7jjAzYiFX3Bht0X8ARULBpIAVkgmws7PWEliNi4Q35Iyk8ThQL00aoNnF3OE";
  static const String appPackageName = "com.infix.lms";

}