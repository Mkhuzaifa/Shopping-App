import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netshop/constants/App_style/AppTextStyle.dart';

import '../constants/App_style/AppColors.dart';
import '../constants/App_style/images.dart';

class View_product extends StatefulWidget {
String? title,image,descripaion;

View_product({this.title,this.descripaion,this.image});

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(child: Icon(Icons.person),backgroundColor: AppColors.orange,),
      )],),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(height: 200,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.indigo),
          child: Image.asset(Appimages.banner,fit: BoxFit.cover,),),
            SizedBox(height: 5,),
          Text(widget.title.toString(),style: AppTextStyle.normalText(fontweight: FontWeight.w400,fontSize: 20),),
          Text(widget.descripaion.toString()),
        ],),
      ) ,
    );
  }
}
// extension Padding on num{
//   SizedBox get ph => SizedBox(height: toDouble(),);
//   SizedBox get pw => SizedBox(width: toDouble(),);
// }