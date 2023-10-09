import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';
import 'package:flutter_single_getx_api_v2/app/modules/home/views/widgets/custom_dashboard_card_tile.dart';
import 'package:get/get.dart';
import '../../../data/dummy_data/student/student_dummy_data.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: 66,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.appLogo),
                )
              ),
            ),
            const Text(
              "Welcome our school",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
        actions: [
          Image.asset(ImagePath.messenger),
          Image.asset(ImagePath.logout),

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              CustomDashboardTile(listItems: student,),

            ],
          ),
        ),
      ),
    );
  }
}