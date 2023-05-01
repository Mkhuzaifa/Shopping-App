import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netshop/component/AppDrawer/AppDrawer.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import '../component/AppDrawer/PrivacyPolicyScreen.dart';
import '../component/AppDrawer/TermsAndConditions.dart';
import '../component/Appbar_Widgets/App_search.dart';
import '../component/Appbar_Widgets/Images_list.dart';
import '../constants/App_style/AppColors.dart';
import '../constants/App_style/AppTextStyle.dart';
import '../constants/Container_style/Banner_container.dart';
import '../constants/Container_style/CarouselSlider.dart';
import '../constants/Container_style/Categoty_container.dart';
import '../constants/Container_style/Product_container1.dart';
class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final searchc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,appBar: AppBar(actions: [

    ],
      backgroundColor: AppColors.successColor,automaticallyImplyLeading: false,
      toolbarHeight: 100,title: Column(
        children: [
          Center(child: Text("Netshop",style: AppTextStyle.normalText(fontweight: FontWeight.w500,colors: AppColors.white,fontSize: 25),),),
        SizedBox(height: 5,),
          AppSearch(onPress: () {}, conroller: searchc,onPress1: () {
          scaffoldKey.currentState!.openDrawer();

    },),
        ],
      ),),
      drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Carousel(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Categories",style: AppTextStyle.normalText(colors: Colors.black,fontSize: 16,fontweight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagelist2.length,
                        itemBuilder: (context, index) {
                          return Categoty_container(image: imagelist[index],title: textlist[index],);
                        },
                      ),
                    ),
                    SizedBox(height: 5,),
                    InkWell(onTap: () {
                      Get.to(LoginScreen());
                    },
                        child: Text("View all",style: AppTextStyle.normalText(colors: Colors.blue),)),
                    SizedBox(height: 5,),
                    Container(
                      child: GridView.builder(shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 300,mainAxisSpacing: 5,crossAxisSpacing: 5),
                        scrollDirection: Axis.vertical,
                        itemCount: imagelist.length,
                        itemBuilder: (context, index) {
                          final url = imagelist[index];
                          return  Product_container(
                            title: "kdnflen",
                            price: "dkfnl",
                            images: imagelist[index],
                          );

                        },),
                    ),

                  ]
              ),
            ),
          ),
        ),
    );
  }
}
