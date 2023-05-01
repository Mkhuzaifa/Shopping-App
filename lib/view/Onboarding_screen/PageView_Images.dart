import 'package:flutter/material.dart';
import 'package:netshop/constants/App_style/images.dart';

import '../../constants/App_style/AppTextStyle.dart';

Widget BuildImage(){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Image.asset(Appimages.page,fit: BoxFit.cover,),
          SizedBox(height: 20,),
          Text("NetShop",style: AppTextStyle.normalText(fontweight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          Text("You can App easily with this shopping.\nYou can contact the customer direct. You can sell and buy products very easily."),
      ],),
    ),
  );
}

Widget BuildImage1(){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Image.asset(Appimages.page1,fit: BoxFit.cover,),
          ),
          SizedBox(height: 20,),
          Text("NetShop",style: AppTextStyle.normalText(fontweight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          Text("You can add this app for free.\nQuickly put your add. Later it will become a\n Premium. Download the app quickly is free."),
        ],),
    ),
  );
}

Widget BuildImage2(){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(Appimages.page3,fit: BoxFit.cover,),
          ),
          SizedBox(height: 20,),
          Text("NetShop",style: AppTextStyle.normalText(fontweight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 5,),
          Text("Online shopping allows customers to browse and \npurchase products from  the comfort of their\n own homes or on-the-go using their mobile devices. \n Thank you for downloading this app."),
        ],),
    ),
  );
}