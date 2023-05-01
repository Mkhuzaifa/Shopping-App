import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/Routes/routes.dart';
import 'package:netshop/Utils/helpers/Utils.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import 'package:provider/provider.dart';
import '../../../constants/App_style/AppColors.dart';
import '../../../constants/App_style/images.dart';
import '../../../view/Dashboard_screen.dart';
import '../../auth_controllers/Verification_Controller.dart';


class Verfiy_Screen extends StatefulWidget {
  const Verfiy_Screen({super.key});
  @override
  State<Verfiy_Screen> createState() => _Verfiy_ScreenState();
}

class _Verfiy_ScreenState extends State<Verfiy_Screen> {

  Timer? timer;
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _auth.currentUser!.sendEmailVerification();
    isVerified = _auth.currentUser!.emailVerified;
    timer = Timer.periodic(Duration(seconds: 4), (_) => EmailVerificatoin());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future EmailVerificatoin() async {
    await _auth.currentUser!.reload();
    setState(() {
      isVerified = _auth.currentUser!.emailVerified;
    });
    if (isVerified) {
      timer?.cancel();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isVerified
        ? dashboard()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(Appimages.verfi),
                  Text(
                    "Email Verification",
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Invalid email please sign in or sign up and comeback again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                 CustomButton(onPress: (){
                   Get.to(LoginScreen());
                   // Navigator.pushNamed(context, RoutesName.login);
                 }, tltle: "Back login", loading: false),

                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't receive link Verification",
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      SizedBox(
                        width: 10,
                      ),

                      ChangeNotifierProvider(create: (_) => Verification_Controller(),
                        child: Consumer<Verification_Controller>(builder: (context, Provider, child) {
                          return InkWell(onTap: () {
                            if(key.currentState!.validate()){

                              Provider.Verification(context);
                              Utils.flushBarMessage("Email has been send check your email", context);
                            }
                          },
                              child:Provider.loading? Container(height: 15,width: 15,
                                  child: Center(child: CircularProgressIndicator())):
                              Text("Resend"));

                        },),),

                    ],
                  )
                ],
              ),
            ),
          );
  }
}
