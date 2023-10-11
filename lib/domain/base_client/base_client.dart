import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../app/data/constants/app_text.dart';
import '../../app/utilities/message/snack_bars.dart';
import 'api_exceptions.dart';

class BaseClient {
  Future<dynamic> getData({
    required String url,
    required Map<String, String> header,
  }) async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: header,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      return returnResponse(response);
    } on SocketException {
      showBasicFailedSnackBar(message: AppText.noInternetConnection);
      throw FetchDataException(AppText.noInternetConnection);
    } on TimeoutException {
      showBasicFailedSnackBar(message: AppText.tryAgainLater);
      throw FetchDataException(AppText.tryAgainLater);
    }
  }

  Future<dynamic> postData({
    required Map<String, dynamic> payload,
    required String url,
    required Map<String, String> header,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(payload),
            headers: header,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      // return response;
      return returnResponse(response);
    } on SocketException {
      showBasicFailedSnackBar(message: AppText.noInternetConnection);
      throw FetchDataException(AppText.noInternetConnection);
    } on TimeoutException {
      showBasicFailedSnackBar(message: AppText.tryAgainLater);
      throw FetchDataException(AppText.tryAgainLater);
    }
  }

  Future<dynamic> deleteData({
    required payload,
    required String url,
    required Map<String, String> header,
  }) async {
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            body: (payload),
            headers: header,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      return returnResponse(response);
    } on SocketException {
      showBasicFailedSnackBar(message: AppText.noInternetConnection);
      throw FetchDataException(AppText.noInternetConnection);
    } on TimeoutException {
      showBasicFailedSnackBar(message: AppText.tryAgainLater);
      throw FetchDataException(AppText.tryAgainLater);
    }
  }

  Future<dynamic> putData({
    required payload,
    required String url,
    required Map<String, String> header,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse(url),
            body: (payload),
            headers: header,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      return returnResponse(response);
    } on SocketException {
      showBasicFailedSnackBar(message: AppText.noInternetConnection);
      throw FetchDataException(AppText.noInternetConnection);
    } on TimeoutException {
      showBasicFailedSnackBar(message: AppText.tryAgainLater);
      throw FetchDataException(AppText.tryAgainLater);
    }
  }
}
