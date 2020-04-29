import 'package:formation_google/model/item_list_user.dart';
import 'package:formation_google/service/current_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static final SaveData _singleton = SaveData._internal();
  SharedPreferences prefs;
  factory SaveData() {
    return _singleton;
  }

  SaveData._internal();

  Future initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  ItemListUser getDataOfUser() {
    List<String> key = prefs.getStringList(CurrentUser.email + "_key");
    List<String> value = prefs.getStringList(CurrentUser.email + "_value");
    return new ItemListUser(key, value);
  }

  Future writePrefData(String key, String value) async{
    List<String> keyList = prefs.getStringList(CurrentUser.email + "_key");
    if(keyList == null){
      keyList = new List<String>();
    }
    keyList.add(key);
    List<String> valueList = prefs.getStringList(CurrentUser.email + "_value");
    if(valueList == null){
      valueList = new List<String>();
    }
    valueList.add(value);

    await prefs.setStringList(CurrentUser.email + "_key", keyList);
    await prefs.setStringList(CurrentUser.email + "_value", valueList);
  }

  Future<bool> deletePrefData(String key,) async{
    List<String> keyList = prefs.getStringList(CurrentUser.email + "_key");
    List<String> valueList = prefs.getStringList(CurrentUser.email + "_value");
    if(keyList == null){
      return true;
    }
    if(valueList != null){
      valueList.removeAt(keyList.indexOf(key));
    }
    keyList.remove(key);

    await prefs.setStringList(CurrentUser.email + "_key", keyList);
    await prefs.setStringList(CurrentUser.email + "_value", valueList);
    return true;
  }

}