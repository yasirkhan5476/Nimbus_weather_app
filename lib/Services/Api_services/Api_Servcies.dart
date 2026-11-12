import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Services/Api_services/Header_services.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';
import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';
class ApiServcies {

  Future<dynamic> patchMethod(String completeUrl, Map<String, dynamic> body, {bool requiresToken = true}) async {
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      var response = await http.patch(
        Uri.parse(completeUrl),
        body: jsonEncode(body),
        headers: headers,
      );
      return getresponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteMethod(String completeUrl, {bool requiresToken = true}) async {
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      var response = await http.delete(
        Uri.parse(completeUrl),
        headers: headers,
      );
      return getresponse(response);
    } catch (e) {
      rethrow;
    }
  }
  getMethod(String completeUrl,{bool requiresToken = true}) async{
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      print("Complete GET url: $completeUrl");
      var response = await http.get(Uri.parse(completeUrl), headers: headers);
      return getresponse(response);
    } catch (e) {
      print("GET Error: $e");
      rethrow;
    }
  }
  postMethod(String completeUrl,Map<String,dynamic> Apibody,{bool requiresToken= true}) async {
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      print("Complete POST url: $completeUrl");
      var response = await http.post(
        Uri.parse(completeUrl),
        body: jsonEncode(Apibody),
        headers: headers,
      );
      return getresponse(response);
    } catch (e) {
      print("POST Error: $e");
      rethrow;
    }
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