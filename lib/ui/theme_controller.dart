// Lab 4 - Ex4: chia sẻ trạng thái Dark Mode xuống mọi màn hình.
//
// Vì sao cần cái này?
// Truyền isDarkMode qua constructor sẽ hỏng khi màn hình được mở bằng
// Navigator.push: MaterialPageRoute dựng widget đúng một lần rồi giữ
// nguyên, nên MyApp đổi state mà màn hình con vẫn hiện giá trị cũ
// (theme toàn app đã tối nhưng công tắc vẫn hiện "Đang tắt").
//
// InheritedWidget đặt ở MaterialApp.builder (nằm TRÊN Navigator) thì
// mọi route bên dưới đều đọc được, và tự rebuild khi giá trị đổi.

import 'package:flutter/material.dart';

class ThemeController extends InheritedWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ThemeController({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
    required super.child,
  });

  /// Đọc controller gần nhất trên cây widget.
  static ThemeController of(BuildContext context) {
    final controller =
        context.dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(
      controller != null,
      'Không tìm thấy ThemeController. Kiểm tra MaterialApp.builder.',
    );
    return controller!;
  }

  /// Đảo trạng thái sáng/tối.
  void toggle() => onChanged(!isDarkMode);

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      oldWidget.isDarkMode != isDarkMode;
}
