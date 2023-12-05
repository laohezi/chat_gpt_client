// Token 管理类
import 'package:get_storage/get_storage.dart';
import 'package:get/utils.dart';
// please change SettingDataSource to Provider
class SettingDataSource {
  static final SettingDataSource _instance = SettingDataSource._internal();
  SettingDataSource._internal();

   factory SettingDataSource(){
    return _instance;
  }


  GetStorage storage = GetStorage();



  // 读取 token
  String readToken() {
    return storage.optReadString(
        'token', "fk209928-9pSV6cq5syJO4mUw4Wt7hLv5OgSptQzC");
  }

  // 保存 token
 saveToken(String token) {
    storage.write('token', token);
  }

 readUrl() {
    return storage.optReadString('url', "https://oa.api2d.net");
  }

  saveUrl(String url) {
    storage.write('url', url);
  }

  readModel() {
    return storage.optReadString('model', "gpt-3.5-turbo");
  }

 saveModel(String model) {
    storage.write('model', model);
  }

 List<String> getModelList() {
    List<String> modelList = ["gpt-3.5-turbo", "gpt-4"];
    return modelList;
  }
}

extension StorageExtention on GetStorage {
  String optReadString(String key, String defaultValue) {
    String? raw = read<String>(key);
    if (raw != null && raw.isNotEmpty) {
      return raw;
    } else {
      return defaultValue;
    }
  }
}
