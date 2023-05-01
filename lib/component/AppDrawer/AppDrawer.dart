import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import 'package:provider/provider.dart';
import '../ widgets/CustomButton.dart';
import '../../constants/App_style/AppColors.dart';
import '../../constants/App_style/AppTextStyle.dart';
import '../../services/auth_controllers/Profile_controller.dart';
import 'PrivacyPolicyScreen.dart';
import 'TermsAndConditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}
class _AppDrawerState extends State<AppDrawer> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("User");

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return _auth.currentUser != null?
    ChangeNotifierProvider(create:(_)=> ProfileController(),
        child: Consumer<ProfileController>(builder: (context, provider , child){
          return  StreamBuilder(
            stream: ref.child(SessionControler().userId.toString()).onValue,
            builder: (context,AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return  SafeArea(child:
                Container(width: 250, child: Drawer(child: ListView(children: [

                  DrawerHeader(decoration: BoxDecoration(color: AppColors.orange),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text("Loading..."),leading: Icon(Icons.person,size: 20,),),
                        SizedBox(height: 10,),

                      ],
                    ),

                  ),

                  ListTile(title: Text("Profile"),leading: Icon(Icons.person),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(title: Text("Product"),leading: Icon(Icons.production_quantity_limits_sharp),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(title: Text("favorite"),leading: Icon(Icons.favorite),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(leading: Icon(Icons.privacy_tip_outlined), title: const Text('Privacy Ploicy'),
                    onTap: () {Get.back();Get.to(()=>PrivacyPolicyScreen());},),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(
                    leading: Icon(Icons.private_connectivity),title: const Text('Terms And Conditions'),
                    onTap: () {Get.back();Get.to(()=>TermsAndConditions());},),

                  ListTile(
                    leading: Icon(Icons.logout),title: const Text('Logout'),
                    onTap: () {
                      auth.signOut();
                      SessionControler().userId = "";
                      Get.to(LoginScreen());

                    },),

                  Divider(color: AppColors.grey.withOpacity(0.4),),
                  ListTile(title: const Text('Version 2.1.0'),
                  ),

                ],),
                ),
                )
                );
              }else if(snapshot.hasData){
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                return SafeArea(child:
                Container(width: 250, child: Drawer(child: ListView(children: [

                  DrawerHeader(child:Center(child: ListTile(title: Text(map["username"],
                    style: AppTextStyle.normalText(colors: Colors.white),),subtitle: Text(map["email"],
                    style: AppTextStyle.normalText(colors: Colors.white,fontSize: 10),),leading: Container(height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: AppColors.orange,
                        shape: BoxShape.circle,border: Border.all(color: AppColors.orange,)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                      child: provider.images == null? map["profile"].toString() == ""?
                      Icon(Icons.person):
                      Image.network(map["profile"],fit: BoxFit.cover,loadingBuilder: (context, child, loadingProgress) {
                        if(loadingProgress ==null)return child;
                        return Center(child: CircularProgressIndicator(color: AppColors.successColor,),);
                      },):
                      Stack(
                        children: [
                          Image.file(File(provider.images!.path,),
                            fit: BoxFit.cover,),
                          Center(child: CircularProgressIndicator(),),
                        ],
                      ),
                    ),
                  ),)),
                    decoration: BoxDecoration(color: AppColors.orange),),

                  ListTile(title: Text("Profile"),leading: Icon(Icons.person),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(title: Text("Product"),leading: Icon(Icons.production_quantity_limits_sharp),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(title: Text("favorite"),leading: Icon(Icons.favorite),),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(leading: Icon(Icons.privacy_tip_outlined), title: const Text('Privacy Ploicy'),
                    onTap: () {Get.back();Get.to(()=>PrivacyPolicyScreen());},),
                  Divider(color: AppColors.grey.withOpacity(0.3),),

                  ListTile(
                    leading: Icon(Icons.private_connectivity),title: const Text('Terms And Conditions'),
                    onTap: () {Get.back();Get.to(()=>TermsAndConditions());},),

                  ListTile(
                    leading: Icon(Icons.logout),title: const Text('Logout'),
                    onTap: () {
                      auth.signOut();
                      SessionControler().userId = "";
                      Get.to(LoginScreen());

                    },),

                  Divider(color: AppColors.grey.withOpacity(0.4),),
                  ListTile(title: const Text('Version 2.1.0'),
                  ),

                ],),
                ),
                )
                );
              }else{
                return   Center(child: Text("Something went wrong "),);
              }
            },);
        }))

    :
    SafeArea(child:
    Container(width: 250, child: Drawer(child: ListView(children: [

      DrawerHeader(child:Center(child: ListTile(title: Text("Guest", style: AppTextStyle.normalText(colors: Colors.white),),subtitle: Text("Guest@gmail.com",
        style: AppTextStyle.normalText(colors: Colors.white,fontSize: 10),),leading: CircleAvatar(child: Icon(Icons.person,size: 25,),radius: 25,))),
        decoration: BoxDecoration(color: AppColors.orange),),



      ListTile(leading: Icon(Icons.privacy_tip_outlined), title: const Text('Privacy Ploicy'),
        onTap: () {Get.back();Get.to(()=>PrivacyPolicyScreen());},),
      Divider(color: AppColors.grey.withOpacity(0.3),),

      ListTile(
        leading: Icon(Icons.private_connectivity),title: const Text('Terms And Conditions'),
        onTap: () {Get.back();Get.to(()=>TermsAndConditions());},),

      Divider(color: AppColors.grey.withOpacity(0.4),),
      ListTile(title: const Text('Version 2.1.0'),
      ),

    ],),
    ),
    )
    );

  }
}