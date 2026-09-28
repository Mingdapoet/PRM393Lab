import 'package:flutter/material.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/screens/lab4/lab4_home.dart';
import 'package:untitled/ui/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Lab 4 - Ex4: state của Dark Mode nằm ở đây vì themeMode
  // thuộc MaterialApp, trên cùng cây widget.
  bool _isDarkMode = false;

  // Giỏ hàng dùng chung cho mọi màn hình của cửa hàng.
  final _cart = CartModel();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // builder chạy TRÊN Navigator, nên mọi màn hình mở bằng
      // Navigator.push đều đọc được ThemeController và rebuild khi đổi.
      builder: (context, child) => ThemeController(
        isDarkMode: _isDarkMode,
        onChanged: (value) => setState(() => _isDarkMode = value),
        child: CartScope(cart: _cart, child: child!),
      ),

      home: const Lab4Home(),
    );
  }
}
