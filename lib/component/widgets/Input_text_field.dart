import 'package:flutter/material.dart';

import '../../constants/App_style/AppColors.dart';


class Input_text_field extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;
  final  Icon? icons;
  final  Widget? sufixicon;
  final  bool? obscureTexts;

  final TextInputType keyboardType;
  final String hint;
  const Input_text_field(
      {required this.myController,
        required this.focusNode,
        required this.onFieldSubmittedValue,
        required this.onValidator,
        required this.hint,
        required this.keyboardType,
        Key? key, this.icons, this.sufixicon,
        this.obscureTexts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

        obscureText: obscureTexts!,
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyboardType,
        cursorHeight: 20,
        cursorColor: AppColors.orange,
        decoration: InputDecoration(
        suffixIcon: sufixicon,
        prefixIcon: icons,
        hintText: hint,

          contentPadding:
          EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey),),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color:  AppColors.orange),
        ),
      ),
    );
  }
}
