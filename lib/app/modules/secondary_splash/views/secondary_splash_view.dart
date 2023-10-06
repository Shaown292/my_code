import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/secondary_splash_controller.dart';

class SecondarySplashView extends GetView<SecondarySplashController> {
  const SecondarySplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash_bg_2.png"),
                fit: BoxFit.fill
            )
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120,),
                SvgPicture.asset("assets/images/group.svg"),
                const SizedBox(height: 40,),
                SvgPicture.asset("assets/images/logo.svg"),
                const Text(
                  AppText.ultimateEducation,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            Container(
              height: 144,
              width: 123,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bottom_curve_bg_sp2.png"),
                      fit: BoxFit.fill
                  )
              ),
              child: Container(
                height: 67,
                width: 67,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bottom_curve_round_sp2.png")
                    )
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
