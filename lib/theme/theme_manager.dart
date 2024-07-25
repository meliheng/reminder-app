import 'package:taskapp/product/util/hive/hive_manager.dart';

final class ThemeManager {
  bool? _isDarkMode = false;
  bool get isDarkMode => _isDarkMode ?? false;
  Future<bool> getThemeFromLocal() async {
    await HiveManager.init<bool>(boxName: "theme");
    var response =
        await HiveManager.getData<bool>(key: "theme", boxName: "theme");
    return _isDarkMode = response?.data ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await HiveManager.saveData<bool>(
        key: "theme", data: value, boxName: "theme");
  }
}
