import 'package:get/get.dart';
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Screen/Rootsrcreen.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class AuthenticationController extends GetxController{
  RxBool isLoading = false.obs;
  RxList sampleList = [].obs;

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