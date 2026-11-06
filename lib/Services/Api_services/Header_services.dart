import 'package:minbus_weather_app/Services/Local_storage/LocalStoragekey.dart';
import 'package:minbus_weather_app/Services/Local_storage/Local_Storage_instance.dart';

class HeaderServices {
  static Map<String,String> HeaderwithApplication(){
    return  {'Content-Type':'application/json'};
  }
  static Map<String,String> HeaderwithTokenbearer(){
    return  {'Content-Type':'application/json',"Authorization":"Bearer ${LocalStorageInstance.getData(key: Localstoragekey.accessToken)}"};
  }
}