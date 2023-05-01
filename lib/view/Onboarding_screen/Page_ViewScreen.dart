import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:page_transition/page_transition.dart';

import '../Splash_screen/SplashScreen.dart';
import 'Getstarted_App.dart';
import 'PageView_Images.dart';
class Page_View extends StatefulWidget {
  const Page_View({Key? key}) : super(key: key);

  @override
  State<Page_View> createState() => _Page_ViewState();
}

class _Page_ViewState extends State<Page_View> {
  final contriller = PageController();
   bool lastpage = false;


   @override
  void initState() {
     setValue();
     FlutterNativeSplash.remove();
    super.initState();
  }

  setValue() async {
     SharedPreferences shrf = await SharedPreferences.getInstance();
     shrf.setBool("visit", true);
     FlutterNativeSplash.remove();

  }

  @override
  void dispose() {
    contriller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      bottomSheet:lastpage? Getstarted_App(): Container(color: Colors.white,
      height: 80,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      TextButton(child: Text("Skip"),onPressed: () {
        Navigator.push(context, PageTransition(
          duration: Duration(milliseconds: 500),
          child: Getstarted_App(), type: PageTransitionType.rightToLeft

        ));
        contriller.jumpToPage(2);
      },),
      Center(child: SmoothPageIndicator(effect: WormEffect(),
        controller: contriller,count: 3,),),
        TextButton(child: Text("Next"),onPressed: () {
          contriller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        },),
    ],),),
      body:
      Container(
        padding: EdgeInsets.only(bottom: 20),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              lastpage = index == 3;
            });

          },
          controller: contriller,
          children: [
            BuildImage()
            ,BuildImage1()
            ,BuildImage2(),
            Getstarted_App(),
          ],
        ),
      ),
    );
  }
}
