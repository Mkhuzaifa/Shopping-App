import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/constants/App_style/AppColors.dart';
import 'package:netshop/services/auth_controllers/Profile_controller.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import 'package:netshop/services/firebase_service/authentication/SignUp_Screen.dart';
import 'package:provider/provider.dart';
import '../component/ widgets/ReusbaleRow.dart';
import '../constants/App_style/AppTextStyle.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({Key? key}) : super(key: key);

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  final double profileimagesize = 150;
  final double Coverimagesize = 200;
  FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref("User");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: auth.currentUser != null
          ? ChangeNotifierProvider(
              create: (_) => ProfileController(),
              child: Consumer<ProfileController>(
                builder: (context, provider, child) {
                  return StreamBuilder(
                    stream: ref.child(SessionControler().userId.toString()).onValue,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        Map<dynamic, dynamic> map = snapshot.data.snapshot.value;


                        return SingleChildScrollView(
                            child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [],
                                  )),
                                  height: height * 2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.successColor,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      )),
                                ),
                                Positioned(
                                  top: 150 - 150 / 2,
                                  child: InkWell(
                                    onTap: () {
                                      provider.pickImage(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      height: 150,
                                      width: 150,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 11),
                                            child: Container(
                                              height: 130,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors.orange,
                                                      width: 2)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: provider.images == null
                                                    ? map["profile"]
                                                                .toString() ==
                                                            ""
                                                        ? Icon(
                                                            Icons.person,
                                                            size: 90,
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                map["profile"],
                                                            fit: BoxFit.cover,
                                                          )
                                                    : Stack(
                                                        children: [
                                                          Image.file(
                                                            File(
                                                              provider
                                                                  .images!.path,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print(
                                                  "1234567890234567890345678");
                                              provider.pickImage(context);
                                            },
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: AppColors.orange,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: AppColors.white,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 1.6,
                            ),
                            ReusbaleRow(
                              value: map["username"],
                              iconData: Icons.person,
                              onPress: () {
                                provider.showUserNameDialogAlert(
                                    context, map["username"].toString());
                              },
                              iconData1: Icons.edit,
                            ),
                            Divider(),
                            ReusbaleRow(
                              value: map["email"],
                              iconData: Icons.email,
                            ),
                            Divider(),
                            ReusbaleRow(
                              value: map["phone"],
                              iconData: Icons.phone,
                              iconData1: Icons.edit,
                              onPress: () {
                                provider.showUserphoneDialogAlert(
                                    context, map["phone"]);
                              },
                            ),
                            Divider(),
                            ReusbaleRow(
                              value: map["joindata"],
                              iconData: Icons.date_range,
                            ),
                            Divider(),
                            SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                                onPress: () {
                                  auth.signOut();
                                  ref.child(SessionControler().userId.toString()).update(
                                      {"onlineStatus": "offline"});
                                  Get.off(LoginScreen());
                                  SessionControler().userId = "";
                                },
                                tltle: "Logout",
                                loading: false),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ));
                      } else {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }
                    },
                  );
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                    radius: 80,
                    backgroundColor: AppColors.orange,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      " Welcome to Shop ",
                      style: AppTextStyle.normalText(
                          colors: AppColors.orange,
                          fontweight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ),
                  Divider(
                    color: AppColors.grey.withOpacity(0.4),
                  ),
                  Center(
                    child: Text(
                      "Enter you email address to\n account to your connect.",
                      style: AppTextStyle.normalText(
                          colors: AppColors.black,
                          fontweight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  CustomButton(
                      onPress: () {
                        Get.off(SignUp_Screen());
                      },
                      tltle: "Create account",
                      loading: false),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      onPress: () {
                        Get.off(LoginScreen());
                      },
                      tltle: "Login",
                      loading: false),
                ],
              ),
            ),
    );
  }
}
