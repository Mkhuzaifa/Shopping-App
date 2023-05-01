import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/App_style/AppColors.dart';
import '../../constants/App_style/AppColors.dart';
import '../../constants/App_style/AppTextStyle.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String tltle;
  final bool loading;

  const CustomButton({
    Key? key, required this.onPress, required this.tltle, required this.loading,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Card(
        child: Container(
          height: 50,
          width: double.infinity,
          child: Center(child: loading? Center(child: CircularProgressIndicator(color: Colors.white,)):Text(tltle,style: AppTextStyle.normalText
            (colors: Colors.white,fontweight: FontWeight.w400),),),
          decoration: BoxDecoration( border: Border.all(color: AppColors.orange, width: 1),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 8,
                  color: Colors.black12.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(10),
          color: AppColors.orange,),
        ),
      ),
    );
  }
}
