import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/book_list_response_model/book_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/book_search_model/book_search_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';

class BookListController extends GetxController {

  LoadingController loadingController = Get.find();
  List<BookListData> bookListData = [];
  List<BookSearchListData> bookSearchList = [];
  bool isTextFieldEmpty = false;

  TextEditingController searchController = TextEditingController();
  List<String>? bottomSheetTitle = ['Book No', 'ISBN No', 'Category', 'Subject', 'Publisher Name'];
  String input = '';

  Future<BookListResponseModel?> getAllBookList() async {

    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.bookList,
        header: GlobalVariable.header,
      );

      BookListResponseModel bookListResponsiveModel = BookListResponseModel.fromJson(response);
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
    return BookListResponseModel();
  }

  void showBookListDetailsBottomSheet({required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.55,
        color: bottomSheetBackgroundColor,
        child: bookListData.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpacing,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(bookListData[index].bookTitle ?? "", style:  AppTextStyle.fontSize14BlackW500,),
            ),
            BottomSheetTile(
              title: "Book No",
              value: bookListData[index].bookNumber,
              color: AppColors.homeworkWidgetColor ,
            ),
            BottomSheetTile(
              title: "ISBN No",
              value: bookListData[index].isbnNo,
              color:  Colors.white,
            ),
            BottomSheetTile(
              title: "Category",
              value: bookListData[index].category,
              color: AppColors.homeworkWidgetColor ,
            ),
            BottomSheetTile(
              title: "Subject",
              value: bookListData[index].subject,
              color:  Colors.white,
            ),
            BottomSheetTile(
              title: "Publisher Name",
              value: bookListData[index].publisherName,
              color: AppColors.homeworkWidgetColor ,
            ),
            BottomSheetTile(
              title: "Author Name",
              value: bookListData[index].authorName,
              color:  Colors.white,
            ),
            BottomSheetTile(
              title: "Quantity",
              value: "${bookListData[index].quantity}",
              color: AppColors.homeworkWidgetColor ,
            ),
            BottomSheetTile(
              title: "Price",
              value: "\$${bookListData[index].price}",
              color:  Colors.white,
            ),
          ],
        )
            : const Center(
          child: Text(
            "No Details Available",
            style: AppTextStyle.fontSize16lightViolateW500,
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  Future<BookSearchModel?> getSearchBook(String bookName) async {

    try {

      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getBookSearch(bookName: bookName),
        header: GlobalVariable.header,
      );

      BookSearchModel bookSearchModel = BookSearchModel.fromJson(response);
      if(bookSearchModel.success == true){
        loadingController.isLoading = false;
        if(bookSearchModel.data!.isNotEmpty){
          for(int i = 0; i < bookSearchModel.data!.length; i++) {
            bookSearchList.add(bookSearchModel.data![i]);
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
    return BookSearchModel();
  }




  @override
  void onInit() {
    getAllBookList();
    super.onInit();
  }
}
