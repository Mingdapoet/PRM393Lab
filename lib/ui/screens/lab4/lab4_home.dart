// Lab 4 - Màn hình menu: mở từng bài trong 5 bài.

import 'package:flutter/material.dart';
import 'package:untitled/ui/screens/lab4/app_structure_demo.dart';
import 'package:untitled/ui/screens/lab4/core_widgets_demo.dart';
import 'package:untitled/ui/screens/lab4/debug_fix_demo.dart';
import 'package:untitled/ui/screens/lab4/input_controls_demo.dart';
import 'package:untitled/ui/screens/lab4/layout_basics_demo.dart';
import 'package:untitled/ui/screens/shop_shell.dart';
import 'package:untitled/ui/theme_controller.dart';

class Lab4Home extends StatelessWidget {
  const Lab4Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 - Flutter UI Fundamentals"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: theme.isDarkMode ? "Light Mode" : "Dark Mode",
            icon: Icon(theme.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: theme.toggle,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExerciseTile(
            number: 1,
            title: "Core Widgets",
            subtitle: "Text, Image, Icon, Card, ListTile",
            icon: Icons.widgets,
            onTap: () => _open(context, const CoreWidgetsDemo()),
          ),
          _ExerciseTile(
            number: 2,
            title: "Input Widgets",
            subtitle: "Slider, Switch, RadioListTile, DatePicker",
            icon: Icons.tune,
            onTap: () => _open(context, const InputControlsDemo()),
          ),
          _ExerciseTile(
            number: 3,
            title: "Layout Basics",
            subtitle: "Column, Row, Padding, ListView.builder",
            icon: Icons.view_agenda,
            onTap: () => _open(context, const LayoutBasicsDemo()),
          ),
          _ExerciseTile(
            number: 4,
            title: "App Structure",
            subtitle: "Scaffold, AppBar, FAB, ThemeData, Dark Mode",
            icon: Icons.dashboard,
            onTap: () => _open(context, const AppStructureDemo()),
          ),
          _ExerciseTile(
            number: 5,
            title: "Debug & Fix",
            subtitle: "4 lỗi UI thường gặp và cách sửa",
            icon: Icons.bug_report,
            onTap: () => _open(context, const DebugFixDemo()),
          ),
          const Divider(height: 32),
          _ExerciseTile(
            number: 0,
            title: "Lab trước - Shop",
            subtitle: "Danh sách sản phẩm, chi tiết, giỏ hàng, mã giảm giá",
            icon: Icons.shopping_bag,
            onTap: () => _open(context, const ShopShell()),
          ),
        ],
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _ExerciseTile extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ExerciseTile({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, size: 20),
        ),
        title: Text(
          number == 0 ? title : "Bài $number - $title",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
