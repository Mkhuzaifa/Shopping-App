import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netshop/Utils/helpers/Utils.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/constants/App_style/AppColors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:uuid/uuid.dart';
import '../../Utils/helpers/Sessions.dart';
import '../../component/ widgets/Input_text_field.dart';
import 'Post_screen.dart';

class Upload_post extends StatefulWidget {
  const Upload_post({Key? key}) : super(key: key);

  @override
  State<Upload_post> createState() => _Upload_postState();
}

class _Upload_postState extends State<Upload_post> {
  var uuid = Uuid();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("post list");
  FirebaseAuth auth = FirebaseAuth.instance;
  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final ProductImage = TextEditingController();
  final NameFocus= FocusNode();
  final DescriptionFocus = FocusNode();
  @override
  void dispose() {
    productName.dispose();
    productDescription.dispose();
    NameFocus.dispose();
    DescriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
                Container(
                  height: height *.35,
                  width: double.infinity,
                  decoration: BoxDecoration(color:AppColors.orange,borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                Input_text_field(keyboardType: TextInputType.name,focusNode: NameFocus,onValidator:(value) {}  ,hint: "Enter product name",myController: productName ,
                  onFieldSubmittedValue: (newValue) {Utils.focusField(context, NameFocus, DescriptionFocus);
                  }, obscureTexts: false,),
                SizedBox(height: 10,),
                Input_text_field(keyboardType: TextInputType.name,focusNode: DescriptionFocus,onValidator:(value) {}  ,hint: "Enter Description name",myController: productDescription ,
                  onFieldSubmittedValue: (newValue) {Utils.focusField(context, NameFocus, DescriptionFocus);
                  }, obscureTexts: false,),
                SizedBox(height: 40,),
                 CustomButton(
              onPress: () async {
                await ref.child(uuid.v1()).set({
                  "userId" : SessionControler().userId.toString(),
                  "imagePath": "https://optedcode.com/wp-content/uploads/2022/10/ceoofoptedcode.png",
                  "title": productName.text.toString(),
                  "description": productDescription.text.toString(),
                }).then((value) {
                  productName.clear();
                  productDescription.clear();
                  PersistentNavBarNavigator.pushNewScreen(context, screen: Postscreen());
                });
              },
              tltle: 'post',
              loading: false,
            ),
              ],

        )
      ),
    );
  }
}
