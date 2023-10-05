import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/core/model/profile_ui_model.dart';

class AuthDatabase {
  static AuthDatabase? _instance;

  AuthDatabase._() {
    _instance = this;
  }

  static AuthDatabase get instance => _instance ?? AuthDatabase._();

  void init() async {
    await GetStorage.init(AuthDBKeys.dbName);
  }

  Future<bool> saveAuthInfo({
    required ProfileModelUI profileModel,
    String? token,
  }) async {
    try {
      final storage = GetStorage(AuthDBKeys.dbName);
      await storage.write(AuthDBKeys.data, jsonEncode(profileModel));
      if (token != null) {
        await storage.write(AuthDBKeys.token, token);
      }
      await storage.save();
      return true;
    } catch (e) {
      return false;
    }
  }
  ProfileModelUI? getUserInfo() {
    try {
      final storage = GetStorage(AuthDBKeys.dbName);
      var data = storage.read(AuthDBKeys.data);
      if (data != null) {
        return ProfileModelUI.fromJson(jsonDecode(data));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  String? getToken() {
    try {
      final storage = GetStorage(AuthDBKeys.dbName);
      debugPrint('Your token is:::: ${storage.read(AuthDBKeys.token)}');
      return storage.read(AuthDBKeys.token);
    } catch (e) {
      rethrow;
    }
  }

  bool auth() {
    try {
      final storage = GetStorage(AuthDBKeys.dbName);
      debugPrint('Your token is:::: ${storage.read(AuthDBKeys.token)}');
      if (storage.read(AuthDBKeys.token) == null) return false;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logOut() async {
    try {
      final storage = GetStorage(AuthDBKeys.dbName);
      await storage.remove(AuthDBKeys.data);
      await storage.remove(AuthDBKeys.token);
      await storage.save();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class AuthDBKeys {
  static const dbName = 'authDb';
  static const data = 'userInfo';
  static const token = 'token';
}
