import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/Routes/routes.dart';

import '../../Utils/helpers/Sessions.dart';
import '../../Utils/helpers/Utils.dart';
import '../../view/Dashboard_screen.dart';
import '../firebase_service/authentication/Verfiy_Screen.dart';

class SignUp_Controller extends ChangeNotifier {

  bool _loading = false;
  List data = [];

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");


  void signup(String username, String email, String password,
      String phonenumber,
      BuildContext context) async {
    setLoading(true);
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) {
            auth.currentUser!.sendEmailVerification();
           SessionControler().userId = value.user!.uid.toString();
            ref.child(value.user!.uid.toString()).set({
            "uid" : value.user!.uid.toString(),
            "email" : email,
            "onlineStatus" : "",
             "phone": phonenumber,
             "username" : username,
              "profile": "",
              "joindata": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              "posts" : data,
            }).then((value) => {
              setLoading(false)
            }).onError((error, stackTrace) => {
              setLoading(false)

            });

        Utils.flushBarMessage("Account create successfully", context);
        setLoading(false);
        Get.off(Verfiy_Screen());
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setLoading(false);
        Utils.flushBarMessage("The password provided is too weak.", context);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setLoading(false);
        print('The account already exists for that email.');
        Utils.flushBarMessage("Email Address is already in use!", context);
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}