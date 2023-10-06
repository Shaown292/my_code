import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_colors.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: homeWidget(),
    );
  }
}


Widget homeWidget() {
  return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      childAspectRatio: 1.1,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      children: List.generate(homeCategoryModelData!.length, (index) {
        return SelectCard(elements:  homeCategoryModelData![index],);
      })
  );
}
class HomeCategoryModel {
  HomeCategoryModel({this.title, this.image,});
  String? title;
  String? image;



}

List<HomeCategoryModel>? homeCategoryModelData = <HomeCategoryModel>[
  HomeCategoryModel(title: 'HOMEWORK', image: ImagePath.homework),
  HomeCategoryModel(title: 'STUDY MATERIALS', image: ImagePath.studyMaterials),
  HomeCategoryModel(title: 'TIMELINE', image: ImagePath.timeline),
  HomeCategoryModel(title: 'ATTENDANCE', image: ImagePath.attendance),
  HomeCategoryModel(title: 'EXAMINATION', image: ImagePath.examination),
  HomeCategoryModel(title: 'ONLINE EXAM', image: ImagePath.onlineExamination),

];

class SelectCard extends StatefulWidget {
  SelectCard({super.key, this.elements});

  HomeCategoryModel? elements;


  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {

  bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFDFBFF),
            border: Border.all(color: const Color(0xFF67329B))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isSelected == false ?
              Container(
                height: 74,
                width: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.homeIconBackgroundColor,
                  image: DecorationImage(
                    image: AssetImage(widget.elements!.image ?? ""),
                  )
                ),
              ) :
              Container(
                height: 74,
                width: 74,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.homeTextColor,
                    image: DecorationImage(
                      image: AssetImage(widget.elements!.image ?? ""),
                    )
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFEBD8FC),
              ),
              Text(
                widget.elements?.title ?? "TITLE",
                style: const TextStyle(
                  color: AppColors.homeTextColor,
                  fontSize: 14.0,
                  fontFamily: 'Poppins-SemiBold',
                  // fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){

        setState(() {
          isSelected = true;
        });


      },
    );
  }
}
