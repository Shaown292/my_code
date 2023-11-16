import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../message/snack_bars.dart';

class FileDownloadUtils {
  Future<void> downloadFile(
      {required String url, required String title}) async {
    var directory = await getApplicationDocumentsDirectory();
    debugPrint('Location:::: $directory');
    showBasicSuccessSnackBar(message: '$directory');
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    showBasicSuccessSnackBar(message: 'Downloading...');
    var file = await DefaultCacheManager().getSingleFile(url);

    OpenFilex.open(file.path);
    await file.writeAsBytes(bytes);
  }
}
