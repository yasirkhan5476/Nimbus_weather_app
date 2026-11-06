import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Services/Api_services/Header_services.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';
import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';
class ApiServcies {
 
  getMethod(String completeUrl) async{
    var response = await http.get(Uri.parse(completeUrl));
    print("Complete url:  ${completeUrl}");
    return getresponse(response);
  }
  postMethod(String completeUrl,Map<String,dynamic> Apibody) async {
    bool? isAccessToken;
    var response = await http.post(Uri.parse(completeUrl),
      body: jsonEncode(Apibody),
      headers: (isAccessToken ?? false) ? HeaderServices.HeaderwithApplication() : HeaderServices.HeaderwithTokenbearer(),
    );
    return getresponse(response);
  }
}
  getresponse(http.Response response){
      print("Response is: ${response.statusCode}");
      switch (response.statusCode){
        case 200:
          return response.body;
        case 201:
          return response.body;
        case 400:
          return Get.snackbar("Error","bad request");
        case 401:
        Get.offAll(LoginScreen());
        LocalStorageInstance.deletedate(key: Localstoragekey.accessToken);
          throw Exception('Unauthorized access.');
        case 404:
          throw Exception('Resource not found.');
        case 409:
          throw Exception("USER_EXISTS");
        case 500:
        default:
          throw Exception('Server Error: ${response.statusCode}');
  }
}