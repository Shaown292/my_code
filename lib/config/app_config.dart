class AppConfig {
  static String domainName = 'https://spondan.com/infixedu';
  static String imageBaseUrl = 'https://spondan.com/infixedu/';

  static String appName = "InfixEdu";

  static bool isDemo = false;

  static String getExtension(String url) {
    var parts = url.split("/");
    return parts[parts.length - 1];
  }

  /// ....................................................
  /// Stripe Payment Gateway
  static const String stripeServerURL =
      'https://api.stripe.com/v1/payment_intents';
  static String stripeCurrency = "USD".toUpperCase();
  static const String stripeMerchantID = "merchant.thegreatestmarkeplace";
  static const String stripePublishableKey =
      "pk_test_51JAWNlKS0igSTFP16dhgcM1fBayh6DStrpu5OA7jjAzYiFX3Bht0X8ARULBpIAVkgmws7PWEliNi4Q35Iyk8ThQL00aoNnF3OE";
  static const String stripeToken =
      'sk_test_51OTydVHHgGZ1rB2oIpSFP0VPpk92x5vXBC30rGfbjITnq3IfjSYZRqOQ78sqTqEX7opbWgqxGxQkPOWbIjUbmBtL00kbanmzce';
  static const String appPackageName = "com.infix.lms";

  ///
  ///PAYPAL
  ///
  static const String paypalDomain =
      "https://api.sandbox.paypal.com"; // "https://api.paypal.com"; // for production mode
  static const String paypalCurrency = 'USD';
  static const String paypalClientId =
      'AQgAWV4PlM9g81xZ51TLtVi68KjB89s4mpcchFschs7OvTM-3p4zsQTDqHOkv5Sw44k9goHlE-VAC7zj';
  static const String paypalClientSecret =
      'ELLoQfnZ4kRbDkul81U_RNRsgHgFPDumlUloCcX6nO6ziXRXKob8gVYaTn6CGCeNVJtBqsfv7VtbsuR2';
  static const bool sandboxMood = true;

  ///
  /// Paystack
  ///
  static const String payStackPublicKey =
      "pk_test_cb290d59b9ec539d7bc3617d1fee3d8a9cdb78b3";
  static const String payStackCurrency = 'ZAR';
}
