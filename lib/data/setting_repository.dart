import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_repository.g.dart';

/// Ngôn ngữ app hỗ trợ. Phần tử đầu tiên là ngôn ngữ mặc định.
const kSupportedLocales = <Locale>[Locale('vi'), Locale('en')];

/// SharedPreferences phải `await getInstance()` mới có, nên provider này
/// không tự tạo được. main() lấy instance trước rồi override vào
/// ProviderScope; nhờ vậy các ViewModel đọc cài đặt đồng bộ, không bị
/// nháy theme/ngôn ngữ mặc định lúc mở app.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'Chưa override sharedPreferencesProvider trong ProviderScope.',
  );
}

@Riverpod(keepAlive: true)
SettingRepository settingRepository(Ref ref) {
  return SettingRepository(ref.watch(sharedPreferencesProvider));
}

/// Đọc / ghi cài đặt của người dùng xuống bộ nhớ máy.
class SettingRepository {
  final SharedPreferences _prefs;

  SettingRepository(this._prefs);

  static const _themeModeKey = 'theme_mode';
  static const _languageKey = 'language_code';

  /// Chế độ sáng/tối đã lưu. Chưa lưu hoặc dữ liệu lạ -> sáng.
  ThemeMode getThemeMode() {
    final name = _prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.light,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  /// Ngôn ngữ đã lưu. Chưa lưu hoặc không được hỗ trợ -> ngôn ngữ mặc định.
  Locale getLocale() {
    final code = _prefs.getString(_languageKey);
    return kSupportedLocales.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => kSupportedLocales.first,
    );
  }

  Future<void> setLocale(Locale locale) =>
      _prefs.setString(_languageKey, locale.languageCode);
}
