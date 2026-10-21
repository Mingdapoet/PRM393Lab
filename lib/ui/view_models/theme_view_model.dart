import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:untitled/data/setting_repository.dart';

part 'theme_view_model.g.dart';

/// Chế độ sáng/tối của toàn app, có lưu lại sau khi tắt app.
///
/// keepAlive: theme dùng suốt vòng đời app, không được tự huỷ khi
/// tạm thời không có widget nào nghe.
@Riverpod(keepAlive: true)
class ThemeViewModel extends _$ThemeViewModel {
  @override
  ThemeMode build() => ref.watch(settingRepositoryProvider).getThemeMode();

  bool get isDarkMode => state == ThemeMode.dark;

  /// Đổi state trước để UI cập nhật ngay, rồi mới ghi xuống máy.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    await ref.read(settingRepositoryProvider).setThemeMode(mode);
  }

  Future<void> setDarkMode(bool isDark) =>
      setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);

  Future<void> toggle() => setDarkMode(!isDarkMode);
}
