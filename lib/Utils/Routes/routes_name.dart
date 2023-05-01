import 'package:flutter/material.dart';
import 'package:netshop/Utils/Routes/routes.dart';
import 'package:netshop/services/firebase_service/authentication/LoginScreen.dart';
import 'package:netshop/services/firebase_service/authentication/SignUp_Screen.dart';
import 'package:netshop/view/Dashboard_screen.dart';
import 'package:netshop/view/Product_Post/Post_screen.dart';
import '../../services/firebase_service/authentication/Forgot_Password.dart';
import '../../view/Profile_screen.dart';

class Routes{

  static Route<dynamic> generateRoutes(RouteSettings routeSettings){
    switch (routeSettings.name){

      case RoutesName.dashboard:return MaterialPageRoute(builder: (_) => dashboard());
      case RoutesName.login:return MaterialPageRoute(builder: (_) => LoginScreen());


      case RoutesName.signup:return MaterialPageRoute(builder: (_) => SignUp_Screen());
      case RoutesName.forgotpasword:return MaterialPageRoute(builder: (_) => Forgot_Password());


      case RoutesName.postscreen:return MaterialPageRoute(builder: (_) => Postscreen());
      case RoutesName.profile:return MaterialPageRoute(builder: (_) => Profile_screen());



      default : return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("No Routes"),),));


    }
  }
}