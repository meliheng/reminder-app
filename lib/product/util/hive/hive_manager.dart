import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskapp/product/base/model/base_response_model.dart';

final class HiveManager {
  static Future<void> init<T>({required String boxName}) async {
    await Hive.initFlutter();
  }

  static Future<void> saveData<T>(
      {required String key, required T data, required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, data);
    await box.close();
  }

  static Future<BaseResponseModel<T>?> getData<T>(
      {required String key, required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    var data = box.get(key);
    await box.close();
    if (data == null) {
      return null;
    } else {
      return BaseResponseModel<T>(data: data);
    }
  }

  static Future<void> deleteData<T>(
      {required String key, required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    await box.delete(key);
  }

  static Future<void> clearData<T>({required String boxName}) async {
    final box = await Hive.openBox<BaseResponseModel>(boxName);
    await box.clear();
  }
}
