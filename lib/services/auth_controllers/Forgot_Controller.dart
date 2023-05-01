import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/Routes/routes.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';

import '../../Utils/helpers/Utils.dart';
import '../../view/Dashboard_screen.dart';

class forgot_Controller extends ChangeNotifier {

  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;


  void forgot(String email,
      BuildContext context) async {
    setLoading(true);
    try {
      final user = await auth.sendPasswordResetEmail(
          email: email,).then((value) {
        setLoading(false);
        Utils.flushBarMessage("Please check your email to recover your password.",context);
        Navigator.pushNamed(context, RoutesName.login);
        setLoading(false);
      });

    } catch (e) {
      print(e);
    }
  }
}