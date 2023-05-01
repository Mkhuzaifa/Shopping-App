import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/helpers/Sessions.dart';
import '../../services/firebase_service/authentication/Verfiy_Screen.dart';
import '../Dashboard_screen.dart';
import '../Onboarding_screen/Page_ViewScreen.dart';

class SplashController {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> checkUserController() async {

    SharedPreferences shrf = await SharedPreferences.getInstance();

    bool? value  = shrf.getBool("visit");
    if (auth.currentUser != null) {
      SessionControler().userId = auth.currentUser!.uid.toString();
      if (auth.currentUser!.emailVerified == true){
        Future.delayed(Duration(seconds: 3)).then((value) => Get.off(dashboard()));
      }else {
        Future.delayed(Duration(seconds: 3)).then((value) => Get.off(Verfiy_Screen()) );
      }
    }else if(value.isNull) {
      Future.delayed(Duration(seconds: 3)).then((value) => Get.off(Page_View()) );
    }else{
      Future.delayed(Duration(seconds: 3)).then((value) => Get.off(LoginScreen()) );
    }

    // if(value.isNull){
    //   Future.delayed(Duration(seconds: 3)).then((value) => Get.off(Page_View()));
    // }else{
    //
    // }


  }

}