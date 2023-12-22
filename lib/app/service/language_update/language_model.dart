class LanguageModelUpdate {
  String? imageUrl;
  String languageName;
  String languageCode;
  String? countryCode;

  LanguageModelUpdate({
    this.imageUrl,
    required this.languageName,
    this.countryCode,
    required this.languageCode
  });
}