import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/book_list_response_model/book_list_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';

class BookListController extends GetxController {

  LoadingController loadingController = Get.find();
  List<BookListData> bookListData = [];


  Future<BookListResponsiveModel?> getAllBookList() async {

    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.bookList,
        header: GlobalVariableController.header,
      );

      BookListResponsiveModel bookListResponsiveModel = BookListResponsiveModel.fromJson(response);
      if(bookListResponsiveModel.success == true){
        loadingController.isLoading = false;
        if(bookListResponsiveModel.data!.isNotEmpty){
          for(int i = 0; i < bookListResponsiveModel.data!.length; i++) {
            bookListData.add(bookListResponsiveModel.data![i]);
          }
        }
      }

    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    getAllBookList();
    super.onInit();
  }
}
