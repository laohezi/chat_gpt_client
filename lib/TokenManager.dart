// Token 管理类
import 'package:get_storage/get_storage.dart';
import 'package:get/utils.dart';

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
}

extension StorageExtention on GetStorage {
  String optReadString(String key, String defaultValue) {
    print("get token");
    String? raw = read<String>(key);
    if (raw != null && raw.isNotEmpty) {
      return raw;
    } else {
      return defaultValue;
    }
  }
}
