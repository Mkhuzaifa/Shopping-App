import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/constants/App_style/images.dart';
import 'package:netshop/services/firebase_service/authentication/SignUp_Screen.dart';
import 'package:netshop/view/Dashboard_screen.dart';

import '../../constants/App_style/AppTextStyle.dart';
import '../../services/firebase_service/authentication/LoginScreen.dart';

class Getstarted_App extends StatefulWidget {
  const Getstarted_App({Key? key}) : super(key: key);

  @override
  State<Getstarted_App> createState() => _Getstarted_AppState();
}

class _Getstarted_AppState extends State<Getstarted_App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Appimages.welcome,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15,),
            Text("Welcome to Netshop ",style: AppTextStyle.normalText(fontweight: FontWeight.bold,fontSize: 20),),
            SizedBox(
              height: 5,
            ),
            Text("You have entered Netshop app of our Thank you for downloading our app. App share with friend.\nCreate an account and place an order.And you can also open an account in Continue as Guest. \nYou Secure in this Netshop."),
            SizedBox(
              height: 20,
            ),
              CustomButton(onPress: () {Get.off(SignUp_Screen());}, tltle: "Create Account", loading: false),
            SizedBox(height: 10,),
            CustomButton(onPress: () {Get.off(dashboard());}, tltle: "Continue as Guest", loading: false),
          ],
        ),
      ),
    );
  }
}
