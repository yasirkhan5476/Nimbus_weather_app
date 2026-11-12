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
  static String getCiteisurlbyregion(int page, int limit, String region) {
    return "$baseurl/cities?page=$page&limit=$limit&region=$region";
  }
  static String Search(String search){
    return "${baseurl}/cities?search=${search}";
  }

  // city details url (/cities/{citySlug})
  static String getCityDetailsUrl(String citySlug) {
    return "$baseurl/cities/$citySlug";
  }

  // city weather url (/cities/{citySlug}/weather)
  static String getCityWeatherUrl(String citySlug) {
    return "$baseurl/cities/$citySlug/weather";
  }

  // city forecast url (/cities/{citySlug}/forecast?days={days})
  static String getCityForecastUrl(String citySlug, int days) {
    return "$baseurl/cities/$citySlug/forecast?days=$days";
  }

  // city places url (/cities/{citySlug}/places)
  static String getCityPlacesUrl(String citySlug) {
    return "$baseurl/cities/$citySlug/places";
  }
  static String FavoriteUrl = "$baseurl/favorites";
}