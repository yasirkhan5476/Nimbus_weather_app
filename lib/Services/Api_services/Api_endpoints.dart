import 'package:http/http.dart' as http;
class ApiEndpoints {
  static String baseurl = "https://nimbus-api-vtoz.onrender.com/api/v1";
  static String citiesurl = "${baseurl}/cities?page=1&limit=8";
  static String loginurl = "${baseurl}/auth/login";
}