import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Screen/Rootsrcreen.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';
import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';

class AuthenticationController extends GetxController{
  RxBool isLoading = false.obs;
  RxList sampleList = [].obs;

  static String? validateEmail(String value)=>RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())? null: "Enter a valid email";
   login(String email,String password) async{
     try{
       isLoading.value=true;
       var responseFromApi = await ApiServcies().postMethod(ApiEndpoints.loginurl,{
         "email": email,
         "password": password
       });
       Get.snackbar("Success", "User Logged In successfully!!");
       isLoading.value = false;
       print("Response From API " + responseFromApi.toString());
       String tokenAccess = jsonDecode(responseFromApi)["token"];
       // print("Access token ${tokenAccess}");
       LocalStorageInstance.savedata(key:Localstoragekey.accessToken, dataToSave: tokenAccess);
       Get.offAll(()=>Rootsrcreen());
     }catch(e){
       isLoading.value = false;
       Get.snackbar("Error", e.toString());
     }
  }
  signup(String name,String email, String password) async {
    try {
      isLoading.value = true;
      var responseFromAPI = await ApiServcies().postMethod(
        ApiEndpoints.registerUrl,
        {"name":name,"email": email, "password": password},
      );
      Get.snackbar("Success", "User Logged In successfully!!");
      isLoading.value = false;
      print("Response From API " + responseFromAPI.toString());
      Get.offAll(()=>LoginScreen());
    } catch(e){
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}