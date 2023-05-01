import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/App_style/AppColors.dart';

class AppSearch extends StatefulWidget {
  final VoidCallback onPress , onPress1;
  final TextEditingController conroller;
  const AppSearch({Key? key, required this.onPress, required this.conroller, required this.onPress1,}) : super(key: key);

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Expanded(
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),    color: Colors.white,),
          child: TextFormField(
            controller:  widget.conroller,
            decoration: InputDecoration(prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),hintText: "Search..."),),
        ),
      ),SizedBox(width: 5,),
      SizedBox(width: 3,),
      Container(height: 50,width: 50,
        decoration:BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColors.orange),
        child: InkWell(
          onTap: widget.onPress,
          child: InkWell(
            onTap: widget.onPress1,
            child: Icon
              (Icons.menu,color: Colors.white,),
          ),
        ),)
    ],);
  }
}
