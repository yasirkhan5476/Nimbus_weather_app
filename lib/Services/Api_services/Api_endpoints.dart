import 'package:http/http.dart' as http;
class ApiEndpoints {
  static String baseurl = "https://nimbus-api-vtoz.onrender.com/api/v1";

  static String loginurl = "${baseurl}/auth/login";
  static String registerUrl = "${baseurl}/auth/register";
  static String getregionurl = "${baseurl}/cities/karachi";

  static String getCitiesdetails(String id){
    return "$baseurl/cities/${id}";
  }

  static String getCiteisurl(int page,int limit){
    return "${baseurl}/cities?page=${page}&limit=${limit}";
  }
  static String Search(String search){
    return "${baseurl}/cities?search=${search}";
  }
}