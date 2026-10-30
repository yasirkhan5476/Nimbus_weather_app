import 'package:http/http.dart' as http;
class ApiEndpoints {
  static String baseurl = "https://nimbus-api-vtoz.onrender.com/api/v1";

  static String loginurl = "${baseurl}/auth/login";
  static String registerUrl = "${baseurl}/auth/register";
  static String getCiteisurl(int page,int limit){
    return "${baseurl}/cities?page=${page}&limit=${limit}";
  }
}