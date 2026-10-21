// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ngôn ngữ của app, có lưu lại sau khi tắt app.

@ProviderFor(LanguageViewModel)
final languageViewModelProvider = LanguageViewModelProvider._();

/// Ngôn ngữ của app, có lưu lại sau khi tắt app.
final class LanguageViewModelProvider
    extends $NotifierProvider<LanguageViewModel, Locale> {
  /// Ngôn ngữ của app, có lưu lại sau khi tắt app.
  LanguageViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageViewModelHash();

  @$internal
  @override
  LanguageViewModel create() => LanguageViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$languageViewModelHash() => r'a79707c9d94d525ad7dcf8727a165dfa69e73b28';

/// Ngôn ngữ của app, có lưu lại sau khi tắt app.

abstract class _$LanguageViewModel extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
