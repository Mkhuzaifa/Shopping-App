import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';
import '../../Utils/helpers/Utils.dart';
import '../../view/Dashboard_screen.dart';
import '../firebase_service/authentication/Verfiy_Screen.dart';

class Login_Controller extends ChangeNotifier {

  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");


  void Login(String email, String password,
      BuildContext context) async {
    setLoading(true);
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
            SessionControler().userId = value.user!.uid.toString();
            setLoading(false);
            if(auth.currentUser!.emailVerified == true){
              return Get.off(dashboard());
            }else{
              auth.currentUser!.sendEmailVerification();
              return Get.off(dashboard());
            }
      });

    }  on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'user-not-found') {
        setLoading(false);
        Utils.flushBarMessage("No user found for that email.",context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setLoading(false);
        Utils.flushBarMessage("invalid password. please try again.",context);
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}