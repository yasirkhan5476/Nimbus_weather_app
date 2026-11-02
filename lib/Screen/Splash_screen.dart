import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Screen/Rootsrcreen.dart';
import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';



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
   // String Accesstoken = GetStorage().read(Localstoragekey.accessToken)??"";
    String Accesstoken = LocalStorageInstance.getData(key: Localstoragekey.accessToken);
    Future.delayed(Duration(seconds:3),(){
      if(Accesstoken==""){
        Get.offAll(()=>LoginScreen());
      }else{
        Get.offAll(()=>Rootsrcreen());
      }
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
