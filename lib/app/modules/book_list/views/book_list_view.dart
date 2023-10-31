import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/modules/book_list/views/widget/book_list_tile.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  const BookListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InfixEduScaffold(
      title: "Book List",
      body: CustomBackground(
        customWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                  itemBuilder: (context, index){
                  return const BookListTile(
                    title: "Horror for Adult",
                    category: "Horror",
                    subject: "Bangla",
                    bookNumber: "12",
                    price: 1000,
                    quantity: 13,
                    rackNo: "12",
                  );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
