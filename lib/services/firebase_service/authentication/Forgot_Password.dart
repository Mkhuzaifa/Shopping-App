import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netshop/component/%20widgets/CustomButton.dart';
import 'package:provider/provider.dart';
import '../../../component/ widgets/Input_text_field.dart';
import '../../../constants/App_style/AppColors.dart';
import '../../../constants/App_style/AppTextStyle.dart';
import '../../../constants/App_style/images.dart';
import '../../auth_controllers/Forgot_Controller.dart';
import 'LoginScreen.dart';


class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Emailcontroller = TextEditingController();
  final confirmcontroller = TextEditingController();

  FocusNode EmailFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Forgot Password", style: AppTextStyle.normalText(
                colors: Colors.white,
                fontweight: FontWeight.w500,
                fontSize: 18),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(onTap: () {
              Get.to(LoginScreen());
            }, child: Icon(Icons.arrow_back))),

        body: SingleChildScrollView(
          child: Form(
            key: key,
            child:Padding(
              padding: const EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),

                    Center(child: Container(height: 200,width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(image:
                          AssetImage(Appimages.person),fit: BoxFit.cover)),)),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Email"),

                    SizedBox(height: 4,),
                    Input_text_field(
                      icons: Icon(Icons.email,color:
                      AppColors.orange,),
                      obscureTexts: false,
                      myController: Emailcontroller,
                      focusNode: EmailFocusNode,
                      onFieldSubmittedValue: (newValue) {},
                      onValidator: (value) {
                        if (value.isEmpty) {
                          return "Email is Empty";
                        }
                      },
                      hint: "",
                      keyboardType: TextInputType.emailAddress,),
                    SizedBox(
                      height: 10,),

                    SizedBox(height: 20,),

                    ChangeNotifierProvider(create: (_) => forgot_Controller(),
                      child: Consumer<forgot_Controller>(builder: (context, Provider, child) {
                        return CustomButton(tltle: "Recover " , loading: Provider.loading,onPress: () {
                          if(key.currentState!.validate()){
                            Provider.forgot(Emailcontroller.text, context);

                          }
                        },);

                      },),),

                    SizedBox(height: 10),

                  ]

              ),
            )
          ),
        ));
  }}
