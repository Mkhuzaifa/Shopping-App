import 'package:flutter/material.dart';

import '../App_style/AppColors.dart';
import '../App_style/AppTextStyle.dart';


class Product_container extends StatelessWidget {
  String? images,title,price;
   Product_container({this.images,this.title,this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: AppColors.orange,
                  image: DecorationImage(
                      image: NetworkImage(images!), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title!,
              style: AppTextStyle.normalText(
                  fontSize: 18, fontweight: FontWeight.w500),overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price!,
                  style: AppTextStyle.normalText(
                      fontSize: 18, fontweight: FontWeight.w500),overflow: TextOverflow.ellipsis
                ),
                Container(
                    height: 20,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.orange),
                    child: Center(
                        child: Text(
                      "New",
                      style: AppTextStyle.normalText(colors: Colors.white),overflow: TextOverflow.ellipsis,
                    ))),
              ],
            ),
            Icon(Icons.favorite,color: AppColors.grey,)
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 4,
              color: Colors.black12.withOpacity(0.1))
        ],
      ),
    );
  }
}
