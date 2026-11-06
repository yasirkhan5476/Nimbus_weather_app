import 'package:get_storage/get_storage.dart';

class LocalStorageInstance {

  static savedata({required String key,required String dataToSave}){
    final box = GetStorage();
    box.write(key, dataToSave);
    return key;
  }
 static String getData({required String key}){
   final box = GetStorage();
    return box.read(key)??"";
  }
  static String deletedate({required String key}){
    final box = GetStorage();
    box.remove(key);
    return key;
  }
}