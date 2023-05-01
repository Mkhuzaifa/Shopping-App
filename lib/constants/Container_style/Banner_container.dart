import 'package:flutter/material.dart';

import '../App_style/AppTextStyle.dart';


class Banner_container extends StatelessWidget {
  String? image;
   Banner_container({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(height: 230,
      margin: EdgeInsets.only(right: 10),
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 160,width: double.infinity,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage(image!),fit: BoxFit.cover)),),
            SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("New shopping app sale",style: AppTextStyle.normalText(fontSize: 18,fontweight: FontWeight.w500),),
                Icon(Icons.favorite,color: Colors.grey,)
              ],
            ), Text("\$45",style: AppTextStyle.normalText(fontSize: 18,fontweight: FontWeight.bold),),
          ],),
      ),
      decoration: BoxDecoration(   border:
      Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black12.withOpacity(0.1))
          ],
          borderRadius: BorderRadius.circular(10),color: Colors.white),);
  }
}
