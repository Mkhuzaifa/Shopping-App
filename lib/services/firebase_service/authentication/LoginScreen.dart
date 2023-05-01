import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:netshop/Utils/helpers/Utils.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:netshop/component/%20widgets/Input_text_field.dart';
import 'package:netshop/view/Dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../../constants/App_style/AppColors.dart';
import '../../../constants/App_style/AppTextStyle.dart';
import '../../../constants/App_style/images.dart';
import '../../../constants/Validater/validate.dart';
import '../../../view/Home_screen.dart';
import '../../../view/Onboarding_screen/Page_ViewScreen.dart';
import '../../auth_controllers/Login_Controller.dart';
import 'Forgot_Password.dart';
import 'SignUp_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  bool _loading = false;
  bool hideobscure = true;
  final key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode PasswordFocusNode = FocusNode();


  @override
  void dispose() {
    EmailController.dispose();
    EmailFocusNode.dispose();
    PasswordController.dispose();
    PasswordFocusNode.dispose();
    super.dispose();
    
  }
  

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    return Scaffold(backgroundColor: Colors.white,
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: height *.2,),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Center(child: Text("Welcome back",style:
                  AppTextStyle.normalText(colors: AppColors.orange,fontweight: FontWeight.bold,fontSize: 32),)),
                  Center(child: Text("Sign in to continue",
                    style: AppTextStyle.normalText(colors: Colors.grey.shade700,fontweight: FontWeight.w500,fontSize: 15),)),

                  SizedBox(height: 30,),
                  InkWell(onTap: () {
                    Get.to(Page_View());
                  }, child: Text("Email")),

                  SizedBox(height: 4,),
                  Input_text_field(
                    myController: EmailController,
                    focusNode: EmailFocusNode, onFieldSubmittedValue: (newValue) {Utils.focusField(context, EmailFocusNode, PasswordFocusNode);},
                    onValidator: (value) {return validateEmail(value);},
                    hint: "", keyboardType: TextInputType.emailAddress,obscureTexts: false,
                    icons: Icon(Icons.email,color: AppColors.orange,),),

                  SizedBox(height: 10,),
                  Text("Password"),

                  SizedBox(height: 4,),
                  Input_text_field(
                    myController: PasswordController,
                    focusNode: PasswordFocusNode,

                    onFieldSubmittedValue:(newValue) {
                      ChangeNotifierProvider(create: (_) => Login_Controller(),
                        child: Consumer<Login_Controller>(builder: (context, Provider, child) {
                          return CustomButton(tltle: "Login " , loading: Provider.loading,onPress: () {
                            if(key.currentState!.validate()){
                              Provider.Login(EmailController.text, PasswordController.text, context);
                            }
                          },);

                        },),);
                    },
                    onValidator: (value) {return validatePassword(value);},
                    keyboardType:TextInputType.emailAddress,
                    hint: "",
                    sufixicon: InkWell(onTap: () {paswod();},
                      child: Icon(hideobscure?Icons.visibility_off : Icons.visibility,
                        color: AppColors.orange,),) , obscureTexts: hideobscure
                    ,icons: Icon(Icons.lock_outline,
                    color: AppColors.orange,size: 23,),),

                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(onTap: () {Get.to(Forgot_Password());},
                          child: Text("Forgot Password?",style: AppTextStyle.normalText(colors: AppColors.orange,fontweight: FontWeight.w500),)),
                    ],
                  ),

                  SizedBox(height: 10,),

                  ChangeNotifierProvider(create: (_) => Login_Controller(),
                    child: Consumer<Login_Controller>(builder: (context, Provider, child) {
                      return CustomButton(tltle: "Login " , loading: Provider.loading,onPress: () {
                        if(key.currentState!.validate()){
                          Provider.Login(EmailController.text, PasswordController.text, context);

                        }
                      },);

                    },),),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(Home_screen());
                        },
                        child: Text("Sign in to continue?",style:
                        AppTextStyle.normalText(colors: Colors.grey.shade700),),
                      )
                      ,SizedBox(width: 2,),
                      InkWell(onTap: () {Get.off(SignUp_Screen());},
                        child: Text("Sign Up ",style:
                        AppTextStyle.normalText(colors: AppColors.orange, fontweight: FontWeight.w500),),)],)
                ],),
            ],
          )

        ),
      ),
    );
  }

  paswod() {
    setState(() {
      hideobscure = !hideobscure;
    });
  }
}



