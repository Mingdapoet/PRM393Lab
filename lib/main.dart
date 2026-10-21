import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/data/setting_repository.dart';
import 'package:untitled/ui/auth_scope.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/screens/lab4/lab4_home.dart';
import 'package:untitled/ui/theme_controller.dart';
import 'package:untitled/ui/view_models/language_view_model.dart';
import 'package:untitled/ui/view_models/theme_view_model.dart';

Future<void> main() async {
  // Cần gọi trước khi dùng plugin (SharedPreferences) ở trước runApp.
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // Giỏ hàng dùng chung cho mọi màn hình của cửa hàng.
  final _cart = CartModel();

  // Trạng thái đăng nhập của cửa hàng.
  final _auth = AuthModel();

  @override
  void dispose() {
    _cart.dispose();
    _auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lab 4 - Ex4: theme và ngôn ngữ lấy từ ViewModel (Riverpod),
    // đổi ở đâu thì MaterialApp cũng dựng lại và lưu xuống máy.
    final themeMode = ref.watch(themeViewModelProvider);
    final locale = ref.watch(languageViewModelProvider);

    return MaterialApp(
      title: "Lab 4 - Flutter UI Fundamentals",
      debugShowCheckedModeBanner: false,

      // --- ThemeData cho Light Mode ---
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // --- ThemeData cho Dark Mode ---
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // themeMode quyết định dùng theme nào.
      themeMode: themeMode,

      // Ngôn ngữ: delegates cung cấp chữ tiếng Việt/Anh cho widget có sẵn
      // (DatePicker, nút của dialog...). Thiếu delegates thì locale 'vi'
      // sẽ báo lỗi "No MaterialLocalizations found".
      locale: locale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,

      // builder chạy TRÊN Navigator, nên mọi màn hình mở bằng
      // Navigator.push đều đọc được ThemeController và rebuild khi đổi.
      // ThemeController giờ chỉ là cầu nối tới ThemeViewModel để các
      // màn hình Lab 4 không phải sửa.
      builder: (context, child) => ThemeController(
        isDarkMode: themeMode == ThemeMode.dark,
        onChanged: (value) =>
            ref.read(themeViewModelProvider.notifier).setDarkMode(value),
        child: AuthScope(
          auth: _auth,
          child: CartScope(cart: _cart, child: child!),
        ),
      ),

      home: const Lab4Home(),
    );
  }
}
