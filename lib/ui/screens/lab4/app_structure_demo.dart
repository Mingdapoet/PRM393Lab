// Lab 4 - Exercise 4: App Structure (Scaffold, AppBar, FAB, ThemeData)
//
// Mục tiêu: dựng cấu trúc màn hình hoàn chỉnh và bật/tắt Dark Mode.
//
// themeMode nằm ở MaterialApp (trên cùng cây widget), nên màn này
// đọc ThemeController để vừa xem vừa đổi theme cho toàn app.

import 'package:flutter/material.dart';
import 'package:untitled/ui/theme_controller.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}

class _AppStructureDemoState extends State<AppStructureDemo> {
  final List<String> _tasks = ["Học Flutter", "Làm Lab 4"];
  int _counter = 2;

  void _addTask() {
    setState(() {
      _counter++;
      _tasks.add("Công việc số $_counter");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.of(context);

    return Scaffold(
      // --- AppBar ---
      appBar: AppBar(
        title: const Text("Ex4 - App Structure"),
        actions: [
          // Nút bật/tắt Dark Mode trên AppBar.
          IconButton(
            tooltip:
                theme.isDarkMode ? "Chuyển Light Mode" : "Chuyển Dark Mode",
            icon: Icon(theme.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: theme.toggle,
          ),
        ],
      ),

      // --- Drawer: menu trượt từ cạnh trái ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text("Menu", style: TextStyle(fontSize: 24)),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text("Trang chủ")),
            const ListTile(
                leading: Icon(Icons.settings), title: Text("Cài đặt")),
          ],
        ),
      ),

      // --- Body ---
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: SwitchListTile(
              title: const Text("Dark Mode"),
              subtitle: Text(theme.isDarkMode ? "Đang bật" : "Đang tắt"),
              secondary: const Icon(Icons.brightness_6),
              value: theme.isDarkMode,
              onChanged: theme.onChanged,
            ),
          ),
          // Expanded cho ListView phần chiều cao còn lại của Column.
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text(_tasks[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() => _tasks.removeAt(index)),
                ),
              ),
            ),
          ),
        ],
      ),

      // --- FloatingActionButton ---
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: "Thêm công việc",
        child: const Icon(Icons.add),
      ),

      // --- BottomNavigationBar ---
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
