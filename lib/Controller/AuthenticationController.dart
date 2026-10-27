import 'package:get/get.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class AuthenticationController extends GetxController{
   login(String email,String password) async{
    var responseFromApi = await ApiServcies().postMethod(ApiEndpoints.loginurl,{
      "email": email,
      "password": password
    });
    print("Response from api"+responseFromApi.toString());
  }
}