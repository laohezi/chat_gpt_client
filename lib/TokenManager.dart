// Token 管理类
import 'package:get_storage/get_storage.dart';
import 'package:get/utils.dart';
// please change SettingDataSource to Provider
class SettingDataSource {
  static GetStorage storage = GetStorage();

  // 读取 token
  static String readToken() {
    GetStorage storage = GetStorage();
    return storage.optReadString(
        'token', "fk209928-9pSV6cq5syJO4mUw4Wt7hLv5OgSptQzC");
  }

  // 保存 token
  static saveToken(String token) {
    storage.write('token', token);
  }

  static readUrl() {
    GetStorage storage = GetStorage();
    return storage.optReadString('url', "https://oa.api2d.net");
  }

  static saveUrl(String url) {
    storage.write('url', url);
  }

  static readModel() {
    GetStorage storage = GetStorage();
    return storage.optReadString('model', "gpt-3.5-turbo");
  }

  static saveModel(String model) {
    storage.write('model', model);
  }

  static List<String> getModelList() {
    List<String> modelList = ["davinci", "curie", "babbage", "ada", "content-filter-alpha-c4", "content-filter-dev"];
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
