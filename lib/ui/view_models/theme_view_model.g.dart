// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Chế độ sáng/tối của toàn app, có lưu lại sau khi tắt app.
///
/// keepAlive: theme dùng suốt vòng đời app, không được tự huỷ khi
/// tạm thời không có widget nào nghe.

@ProviderFor(ThemeViewModel)
final themeViewModelProvider = ThemeViewModelProvider._();

/// Chế độ sáng/tối của toàn app, có lưu lại sau khi tắt app.
///
/// keepAlive: theme dùng suốt vòng đời app, không được tự huỷ khi
/// tạm thời không có widget nào nghe.
final class ThemeViewModelProvider
    extends $NotifierProvider<ThemeViewModel, ThemeMode> {
  /// Chế độ sáng/tối của toàn app, có lưu lại sau khi tắt app.
  ///
  /// keepAlive: theme dùng suốt vòng đời app, không được tự huỷ khi
  /// tạm thời không có widget nào nghe.
  ThemeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeViewModelHash();

  @$internal
  @override
  ThemeViewModel create() => ThemeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeViewModelHash() => r'b66495bbeb128c34e49f836d6c7be06204f6f23b';

/// Chế độ sáng/tối của toàn app, có lưu lại sau khi tắt app.
///
/// keepAlive: theme dùng suốt vòng đời app, không được tự huỷ khi
/// tạm thời không có widget nào nghe.

abstract class _$ThemeViewModel extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
