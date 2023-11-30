import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  RxString categoryInitValue = "Horror".obs;
  RxList<String> categoryList = [
    "Horror",
    "Comedy",
    "Novel"
  ].obs;

  RxString audienceInitValue = "Child".obs;
  RxList<String> audienceList = [
    "Child",
    "Adult",
    "Teen"
  ].obs;
}
