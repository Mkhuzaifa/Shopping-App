import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:netshop/view/Home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../constants/App_style/AppColors.dart';
import 'Chat_Screen/Chat_screen.dart';
import 'Product_Post/Post_screen.dart';
import 'Product_Post/Upload_post.dart';

import 'Profile_screen.dart';


class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final controler = PersistentTabController(initialIndex: 0);


  List<Widget> screens(){
    return [
      Home_screen(),
      Postscreen(),
      Upload_post(),
      Chat_screen(),
      Profile_screen(),
    ];
  }
  List<PersistentBottomNavBarItem> Itembar(){
    return [
      PersistentBottomNavBarItem(icon: Icon(Icons.home),
      activeColorPrimary: AppColors.orange,
      inactiveColorPrimary: Colors.white),

      PersistentBottomNavBarItem(icon: Icon(Icons.production_quantity_limits_rounded),
          activeColorPrimary: AppColors.orange,
          inactiveColorPrimary: Colors.white),

      PersistentBottomNavBarItem(icon: Icon(Icons.add,color: Colors.white),
         activeColorPrimary: AppColors.orange,
         inactiveIcon: Icon(Icons.add,color: Colors.white,)),

      PersistentBottomNavBarItem(icon: Icon(Icons.message),
          activeColorPrimary: AppColors.orange,
          inactiveColorPrimary: Colors.white),

      PersistentBottomNavBarItem(icon: Icon(Icons.person),
          activeColorPrimary: AppColors.orange,
          inactiveColorPrimary: Colors.white),
    ];
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,controller: controler,
      items: Itembar(),
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(0)),
      backgroundColor: AppColors.successColor.withOpacity(0.9),
      screens: screens(),navBarStyle: NavBarStyle.style15,
    );
  }
}

