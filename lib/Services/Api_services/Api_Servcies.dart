import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:minbus_weather_app/Screen/Auth/login_Screen.dart';
import 'package:minbus_weather_app/Services/Api_services/Header_services.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';
import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';

class ApiServcies {
  Future<dynamic> getMethod(String completeUrl, {bool requiresToken = true}) async {
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

  Future<dynamic> postMethod(String completeUrl, Map<String, dynamic> Apibody, {bool requiresToken = true}) async {
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

  Future<dynamic> patchMethod(String completeUrl, Map<String, dynamic> body, {bool requiresToken = true}) async {
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      print("Complete PATCH url: $completeUrl");
      var response = await http.patch(
        Uri.parse(completeUrl),
        body: jsonEncode(body),
        headers: headers,
      );
      return getresponse(response);
    } catch (e) {
      print("PATCH Error: $e");
      rethrow;
    }
  }

  Future<dynamic> deleteMethod(String completeUrl, {bool requiresToken = true}) async {
    try {
      Map<String, String> headers = requiresToken
          ? HeaderServices.HeaderwithTokenbearer()
          : HeaderServices.HeaderwithApplication();

      print("Complete DELETE url: $completeUrl");
      var response = await http.delete(
        Uri.parse(completeUrl),
        headers: headers,
      );
      return getresponse(response);
    } catch (e) {
      print("DELETE Error: $e");
      rethrow;
    }
  }
}

dynamic getresponse(http.Response response) {
  print("Response is: ${response.statusCode}");
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.body;
    case 400:
      Get.snackbar("Error", "Bad request");
      throw Exception('Bad request');
    case 401:
      Get.offAll(() => const LoginScreen());
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