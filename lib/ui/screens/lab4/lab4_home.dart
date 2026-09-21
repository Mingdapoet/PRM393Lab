// Lab 4 - Màn hình menu: mở Bài 1 và Bài 2.

import 'package:flutter/material.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/screens/lab4/core_widgets_demo.dart';
import 'package:untitled/ui/screens/lab4/input_controls_demo.dart';

class Lab4Home extends StatelessWidget {
  const Lab4Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 - Flutter UI Fundamentals"),
        centerTitle: true,
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
          const Divider(height: 32),
          _ExerciseTile(
            number: 0,
            title: "Lab trước - Product List",
            subtitle: "Danh sách sản phẩm (Lab 2)",
            icon: Icons.shopping_bag,
            onTap: () => _open(context, const HomePage()),
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
