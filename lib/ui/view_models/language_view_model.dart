import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:untitled/data/setting_repository.dart';

part 'language_view_model.g.dart';

/// Ngôn ngữ của app, có lưu lại sau khi tắt app.
@Riverpod(keepAlive: true)
class LanguageViewModel extends _$LanguageViewModel {
  @override
  Locale build() => ref.watch(settingRepositoryProvider).getLocale();

  /// Bỏ qua ngôn ngữ không nằm trong [kSupportedLocales].
  Future<void> setLocale(Locale locale) async {
    final supported = kSupportedLocales.any(
      (l) => l.languageCode == locale.languageCode,
    );
    if (!supported || state.languageCode == locale.languageCode) return;

    state = locale;
    await ref.read(settingRepositoryProvider).setLocale(locale);
  }

  /// Đổi qua lại giữa tiếng Việt và tiếng Anh.
  Future<void> toggle() => setLocale(
    state.languageCode == 'vi' ? const Locale('en') : const Locale('vi'),
  );
}
