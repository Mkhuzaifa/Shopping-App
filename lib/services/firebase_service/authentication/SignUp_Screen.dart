import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netshop/Utils/helpers/Utils.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/component/%20widgets/Input_text_field.dart';
import 'package:netshop/services/firebase_service/authentication/Verfiy_Screen.dart';
import 'package:provider/provider.dart';

import '../../../constants/App_style/AppColors.dart';
import '../../../constants/App_style/AppTextStyle.dart';
import '../../../constants/Validater/validate.dart';
import '../../auth_controllers/SignUp_controller.dart';
import 'LoginScreen.dart';
class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  bool _loading = false;
  bool hide = true;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final confirmController = TextEditingController();
  final PhoneController = TextEditingController();
  final NameController = TextEditingController();

  FocusNode EmailFocusNode = FocusNode();
  FocusNode PasswordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  FocusNode NameFocusNode = FocusNode();
  FocusNode PhoneFocusNode = FocusNode();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    NameController.dispose();
    NameFocusNode.dispose();
    EmailController.dispose();
    EmailFocusNode.dispose();
    PasswordController.dispose();
    PasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(onTap: () {Get.to(LoginScreen());}, child: Icon(Icons.arrow_back))),

      body: Form(
        key: key,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: ChangeNotifierProvider(
              create: (context) => SignUp_Controller(),
              child: Consumer<SignUp_Controller>(
                builder: (context, Provider, child) {
                  return ListView(shrinkWrap: true,
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(" Welcome to Shop ", style: AppTextStyle.normalText(
                                colors: AppColors.orange,
                                fontweight: FontWeight.bold,
                                fontSize: 28),),
                          ),
                          Center(
                            child: Text("Enter you email address to\n account to your connect ", style: AppTextStyle.normalText(
                                colors: AppColors.black,
                                fontweight: FontWeight.w500,
                                fontSize: 14),),
                          ),


                          SizedBox(height: 10,),
                          Text("Username"),

                          SizedBox(height: 4,),
                          Input_text_field(myController: NameController,
                            focusNode: NameFocusNode,
                            onFieldSubmittedValue:(newValue) {Utils.focusField(context, NameFocusNode, EmailFocusNode);},
                            onValidator: (value) {if(NameController.text.isEmpty){return "Name is required";}},
                            keyboardType: TextInputType.name,
                            obscureTexts: false,
                            hint: "",
                            icons: Icon(
                              Icons.person, color: AppColors.orange, size: 23,),),
                          SizedBox(height: 10,),

                          Text("Email"),
                          SizedBox(height: 4,),

                          Input_text_field(myController: EmailController,
                            focusNode: EmailFocusNode,
                            onFieldSubmittedValue:(newValue) {Utils.focusField(context, EmailFocusNode, PhoneFocusNode);},
                            onValidator: (value) {return validateEmail(value);},
                            keyboardType: TextInputType.name,
                            obscureTexts: false,
                            hint: "",
                            icons: Icon(
                              Icons.email, color: AppColors.orange, size: 23,),),
                          SizedBox(height: 10,),

                          Text("Phone"),
                          SizedBox(height: 4,),

                          Input_text_field(myController: PhoneController,
                            focusNode: PhoneFocusNode,
                            onFieldSubmittedValue:(newValue) {Utils.focusField(context, PhoneFocusNode, PasswordFocusNode);},
                            onValidator: (value) {return phonevalidata(value);},
                            keyboardType: TextInputType.phone,
                            obscureTexts: false,
                            hint: "",
                            icons: Icon(
                              Icons.phone, color: AppColors.orange, size: 23,),),
                          SizedBox(height: 10,),

                          InkWell(onTap: () {
                            Get.to(Verfiy_Screen());
                          },
                              child: Text("Password")),
                          SizedBox(height: 4,),

                          Input_text_field(myController: PasswordController
                            , focusNode: PasswordFocusNode,
                            onFieldSubmittedValue:(newValue) {Utils.focusField(context, PasswordFocusNode, confirmFocusNode);},
                            onValidator:(value) {return validatePassword(value);},
                            keyboardType:TextInputType.emailAddress,
                            hint: "",
                            obscureTexts: hide,
                            sufixicon: InkWell(onTap: () {
                              passwor();
                            },child: Icon(hide? Icons.visibility_off:
                            Icons.visibility,color:AppColors.orange,),),
                            icons: Icon(
                              Icons.lock_outline, color:AppColors.orange, size: 23,),
                          ),
                          SizedBox(height: 10,),

                          Text("Confirm password"),
                          SizedBox(height: 4,),

                          Input_text_field(myController: confirmController
                            , focusNode: confirmFocusNode,
                            onFieldSubmittedValue:(newValue) {
                              if(key.currentState!.validate()){
                                Provider.signup(NameController.text, EmailController.text,
                                    PasswordController.text, PhoneController.text, context);
                              }
                            },
                            onValidator:(value) {
                              if (value!.isEmpty) {
                                return "Confirm Password";
                              } else if (value.length < 6) {
                                return "password must be grater then 6 characters";
                              } else if (PasswordController.text != confirmController.text) {
                                return ("Password can't same");
                              }
                              return null;
                            },
                            keyboardType:TextInputType.emailAddress,
                            hint: "",
                            obscureTexts: hide,
                            icons: Icon(
                              Icons.lock_outline, color:AppColors.orange, size: 23,),
                          ),
                          SizedBox(height: 15,),

                          CustomButton(onPress: () {
                            if(key.currentState!.validate()){
                              Provider.signup(NameController.text, EmailController.text,
                                  PasswordController.text, PhoneController.text, context);
                            }
                          }, tltle: "Sign Up", loading: Provider.loading),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sign in to continue?", style:
                              AppTextStyle.normalText(colors: Colors.grey.shade700),)
                              , SizedBox(width: 2,),
                              InkWell(
                                onTap: () {
                                  Get.to(LoginScreen());
                                },
                                child: Text("Login Account ", style:
                                AppTextStyle.normalText(colors: AppColors.orange,
                                    fontweight: FontWeight.w500),),
                              )
                            ],)


                        ],),
                    ],);
                },
              ),
            ),

        ),
      ),
    );
  }
  passwor(){
    setState(() {
      hide = !hide;
    });
  }
}
