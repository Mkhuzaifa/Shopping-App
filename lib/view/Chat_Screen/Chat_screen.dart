import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';
import 'package:netshop/constants/App_style/AppColors.dart';

import 'Message_screen.dart';

class Chat_screen extends StatefulWidget {
  const Chat_screen({Key? key}) : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  final  ref = FirebaseDatabase.instance.ref().child("User");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Chat Screen"),),
      body:SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index) {
            if(SessionControler().userId == snapshot.child("uid").value.toString()){
              return Container();
            }else{
              return Column(
                children: [

                  ListTile(onTap: () {
                    Get.to(Message_screen(receiver:snapshot.child("uid").value.toString() ,
                        Name:snapshot.child("username").value.toString(),image:  snapshot.child("profile").value.toString()));
                  },
                    subtitle:  Text(snapshot.child("email").value.toString()),
                    title: Text(snapshot.child("username").value.toString()),
                    leading: snapshot.child("profile").value.toString() == "" ? CircleAvatar(backgroundColor: AppColors.grey,
                        child: Icon(Icons.person,size: 30,color: AppColors.white,)):
                    ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: Container(height: 50,width: 50,decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.orange,),
                          child: CachedNetworkImage(imageUrl: snapshot.child("profile").value.toString(),fit: BoxFit.cover,),)),),

                ],
              );
            }

          },),
      ),
    );
  }
}
