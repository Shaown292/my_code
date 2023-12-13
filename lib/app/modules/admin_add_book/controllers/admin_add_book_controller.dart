import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/extensions/widget.extensions.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/book_category_and_subject_list_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminAddBookController extends GetxController {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController bookNumberTextController = TextEditingController();
  TextEditingController isbnTextController = TextEditingController();
  TextEditingController publisherNameTextController = TextEditingController();
  TextEditingController authorNameTextController = TextEditingController();
  TextEditingController rackNumberTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  LoadingController loadingController = Get.find();
  RxBool addBookLoader = false.obs;

  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal());

  RxList<Categories> bookCategoryList = <Categories>[].obs;
  Rx<Categories> bookCategoryInitValue =
      Categories(id: -1, name: "Add Category").obs;
  RxInt bookCategoryId = 0.obs;

  RxList<Subjects> bookSubjectList = <Subjects>[].obs;
  Rx<Subjects> bookSubjectInitValue = Subjects(id: -1, name: "Add Subject").obs;
  RxInt bookSubjectId = 0.obs;

  Future<BookCategoryAndSubjectListResponseModel>
      getAdminBookCategoryAndSubjectList() async {
    try {
      bookCategoryList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminBookCategoryAndSubjectList,
          header: GlobalVariable.header);

      BookCategoryAndSubjectListResponseModel
          bookCategoryAndSubjectListResponseModel =
          BookCategoryAndSubjectListResponseModel.fromJson(response);

      if (bookCategoryAndSubjectListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (bookCategoryAndSubjectListResponseModel
            .data!.categories!.isNotEmpty) {
          for (int i = 0;
              i <
                  bookCategoryAndSubjectListResponseModel
                      .data!.categories!.length;
              i++) {
            bookCategoryList.add(
                bookCategoryAndSubjectListResponseModel.data!.categories![i]);
          }
          bookCategoryId.value = bookCategoryList[0].id!;
          bookCategoryInitValue.value = bookCategoryList[0];
        }
        if (bookCategoryAndSubjectListResponseModel
            .data!.subjects!.isNotEmpty) {
          for (int i = 0;
              i <
                  bookCategoryAndSubjectListResponseModel
                      .data!.subjects!.length;
              i++) {
            bookSubjectList.add(
                bookCategoryAndSubjectListResponseModel.data!.subjects![i]);
          }
          bookSubjectId.value = bookSubjectList[0].id!;
          bookSubjectInitValue.value = bookSubjectList[0];
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: bookCategoryAndSubjectListResponseModel.message ??
              AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return BookCategoryAndSubjectListResponseModel();
  }

  Future<void> addAdminBook(
      {required int bookCategoryId, required int bookSubjectId}) async {
    try {
      addBookLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.postAdminAddBook,
          header: GlobalVariable.header,
          payload: {
            'book_title': titleTextController.text,
            'book_category_id': bookCategoryId,
            'book_number': bookNumberTextController.text,
            'isbn_no': isbnTextController.text,
            'publisher_name': publisherNameTextController.text,
            'author_name': authorNameTextController.text,
            'subject_id': bookSubjectId,
            'rack_number': rackNumberTextController.text,
            'quantity': quantityTextController.text,
            'book_price': priceTextController.text,
            'details': descriptionTextController.text,
            'post_date': dateTextController.text,
          });

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        titleTextController.clear();
        bookNumberTextController.clear();
        isbnTextController.clear();
        publisherNameTextController.clear();
        authorNameTextController.clear();
        rackNumberTextController.clear();
        quantityTextController.clear();
        priceTextController.clear();
        descriptionTextController.clear();
        dateTextController.clear();

        addBookLoader.value = false;
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? "");
      } else {
        addBookLoader.value = false;
        showBasicSuccessSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong,
        );
      }
    } catch (e, t) {
      addBookLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      addBookLoader.value = false;
    }
  }

  bool validation() {
    if (titleTextController.text == '') {
      showBasicFailedSnackBar(message: 'Add Book Title');
      return false;
    }
    if (bookCategoryList.isEmpty) {
      showBasicFailedSnackBar(message: 'No Category available');
      return false;
    }
    if (bookSubjectList.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Subject available.');
      return false;
    }

    return true;
  }

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      dateTextController.text = dateTime.dd_mm_yyyy;
    }
  }

  @override
  void onInit() {
    getAdminBookCategoryAndSubjectList();
    super.onInit();
  }
}
