import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../App_style/AppColors.dart';
import '../App_style/AppTextStyle.dart';

class product_container extends StatelessWidget {
  VoidCallback? onPress;
  String?  imageurl;
  String? title,price;
   product_container({this.onPress,this.title,this.price,this.imageurl});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:160,
                width: double.infinity,
                child:  Container(
                  height: 170,width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey.shade400,
                      image: DecorationImage(image: AssetImage(imageurl!),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),),
              ),
              SizedBox(height: 3,),
              Text(title!,style: AppTextStyle.normalText(colors: AppColors.black,fontweight: FontWeight.w400,fontSize: 17,),overflow: TextOverflow.ellipsis,),
              RatingBar.builder(
                itemSize: 20,
                initialRating: 3,
                minRating: 4,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 4,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(price!,style: AppTextStyle.normalText(fontSize: 18,fontweight: FontWeight.w500),),
                  Icon(Icons.production_quantity_limits_sharp)
                ],
              )
            ],
          ),
        ),
        margin: EdgeInsets.all(5),
        height: 250,
        width: 180,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.black,
          border:
          Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black12.withOpacity(0.1))
          ],),
      ),
    );
  }
}
