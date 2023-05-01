import 'package:flutter/material.dart';

import '../App_style/AppTextStyle.dart';




class Categoty_container extends StatelessWidget {
  String? image,title;
   Categoty_container({this.image,this.title});

  @override
  Widget build(BuildContext context) {
    return    Card(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(height: 150,width: 120,

          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image!),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),color: Colors.white54 ,  border:
          Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black12.withOpacity(0.1))
            ],),),
      ),
    );
  }
}
