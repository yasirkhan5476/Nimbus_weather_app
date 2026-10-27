import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3),(){
      Get.to(()=>LoginScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.Iconscolor,
      body: SafeArea(

          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nimbus",style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold,color: Colors.white),),
                Text("Weather & city guide",style: TextStyle(fontSize: 16,color: Colors.white),),
                SizedBox(height: 30,),
                Text("Weather & city guide",style: TextStyle(fontSize: 16,color: Colors.white),),

              ],
                  ),
          )),
    );
  }
}
