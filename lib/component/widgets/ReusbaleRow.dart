import 'package:flutter/material.dart';

class ReusbaleRow extends StatelessWidget {
 final String value;
 IconData iconData ;
 IconData? iconData1;
  VoidCallback? onPress ;
   ReusbaleRow({required this.value,required this.iconData,  this.iconData1,this.onPress});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        ListTile(title: Text(value),leading: Icon(iconData),trailing: InkWell(onTap: onPress,
            child: Icon(iconData1)),),
      ],
    );
  }
}
