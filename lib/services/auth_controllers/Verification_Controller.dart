import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../Utils/helpers/Utils.dart';

class Verification_Controller extends ChangeNotifier {

  bool _loading = false;
  get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;


  void  Verification(BuildContext context) async {
    setLoading(true);
    try {
      final user = await auth.currentUser!.sendEmailVerification(
        ).then((value) {
        setLoading(false);
        Utils.flushBarMessage("Email has been send check your email",context);
        setLoading(false);
      });

    } catch (e) {
      print(e);
    }
  }
}