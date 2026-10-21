// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SharedPreferences phải `await getInstance()` mới có, nên provider này
/// không tự tạo được. main() lấy instance trước rồi override vào
/// ProviderScope; nhờ vậy các ViewModel đọc cài đặt đồng bộ, không bị
/// nháy theme/ngôn ngữ mặc định lúc mở app.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// SharedPreferences phải `await getInstance()` mới có, nên provider này
/// không tự tạo được. main() lấy instance trước rồi override vào
/// ProviderScope; nhờ vậy các ViewModel đọc cài đặt đồng bộ, không bị
/// nháy theme/ngôn ngữ mặc định lúc mở app.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// SharedPreferences phải `await getInstance()` mới có, nên provider này
  /// không tự tạo được. main() lấy instance trước rồi override vào
  /// ProviderScope; nhờ vậy các ViewModel đọc cài đặt đồng bộ, không bị
  /// nháy theme/ngôn ngữ mặc định lúc mở app.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'c56421fcd7341f3f2f2178b25ce49b1103a3f10b';

@ProviderFor(settingRepository)
final settingRepositoryProvider = SettingRepositoryProvider._();

final class SettingRepositoryProvider
    extends
        $FunctionalProvider<
          SettingRepository,
          SettingRepository,
          SettingRepository
        >
    with $Provider<SettingRepository> {
  SettingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingRepository create(Ref ref) {
    return settingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingRepository>(value),
    );
  }
}

String _$settingRepositoryHash() => r'7732b56f08da343aa20cce98b7864b29f0d2194c';
