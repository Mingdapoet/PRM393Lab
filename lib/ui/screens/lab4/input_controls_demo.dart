// Lab 4 - Exercise 2: Input Widgets (Slider, Switch, RadioListTile, DatePicker)
//
// Mục tiêu: dựng UI tương tác cho phép người dùng thay đổi giá trị.
// Dùng StatefulWidget vì giá trị thay đổi theo thao tác người dùng.

import 'package:flutter/material.dart';

enum ShipMethod { standard, express, pickup }

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Mỗi biến state tương ứng một input widget bên dưới.
  double _quantity = 1;
  bool _giftWrap = false;
  ShipMethod _shipMethod = ShipMethod.standard;
  DateTime? _deliveryDate;

  String get _shipLabel => switch (_shipMethod) {
    ShipMethod.standard => "Tiêu chuẩn (3-5 ngày)",
    ShipMethod.express => "Nhanh (1-2 ngày)",
    ShipMethod.pickup => "Nhận tại cửa hàng",
  };

  // DatePicker phải gọi từ callback (onPressed) với BuildContext hợp lệ.
  // Gọi thẳng trong build() sẽ mở lặp vô hạn.
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _deliveryDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    // Sau await, widget có thể đã bị gỡ khỏi cây -> setState lúc này sẽ lỗi.
    if (!mounted) return;

    // Người dùng có thể bấm Cancel -> picked == null.
    if (picked != null) {
      setState(() => _deliveryDate = picked);
    }
  }

  String _formatDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/${d.year}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ex2 - Input Widgets")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Slider: chọn số lượng ---
          Text("Số lượng: ${_quantity.round()}",
              style: Theme.of(context).textTheme.titleMedium),
          Slider(
            value: _quantity,
            min: 1,
            max: 10,
            divisions: 9,
            label: _quantity.round().toString(),
            // setState báo Flutter vẽ lại với giá trị mới.
            onChanged: (value) => setState(() => _quantity = value),
          ),
          const SizedBox(height: 8),

          // --- Switch: bật/tắt gói quà ---
          SwitchListTile(
            title: const Text("Gói quà tặng"),
            subtitle: const Text("Phụ thu 20.000đ"),
            value: _giftWrap,
            onChanged: (value) => setState(() => _giftWrap = value),
          ),
          const Divider(),

          // --- RadioListTile: chọn 1 trong nhiều ---
          // Flutter 3.32+ quản lý lựa chọn bằng RadioGroup bọc ngoài,
          // thay cho groupValue/onChanged trên từng tile (đã deprecated).
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Phương thức giao hàng",
                style: Theme.of(context).textTheme.titleMedium),
          ),
          RadioGroup<ShipMethod>(
            groupValue: _shipMethod,
            onChanged: (value) {
              if (value != null) setState(() => _shipMethod = value);
            },
            child: const Column(
              children: [
                RadioListTile<ShipMethod>(
                  value: ShipMethod.standard,
                  title: Text("Tiêu chuẩn (3-5 ngày)"),
                ),
                RadioListTile<ShipMethod>(
                  value: ShipMethod.express,
                  title: Text("Nhanh (1-2 ngày)"),
                ),
                RadioListTile<ShipMethod>(
                  value: ShipMethod.pickup,
                  title: Text("Nhận tại cửa hàng"),
                ),
              ],
            ),
          ),
          const Divider(),

          // --- DatePicker: mở qua nút bấm ---
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: const Text("Chọn ngày giao hàng"),
          ),
          const SizedBox(height: 16),

          // --- Hiển thị lại toàn bộ giá trị đã chọn ---
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thông tin đơn hàng",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text("Số lượng: ${_quantity.round()}"),
                  Text("Gói quà: ${_giftWrap ? 'Có' : 'Không'}"),
                  Text("Giao hàng: $_shipLabel"),
                  Text(
                    "Ngày giao: "
                    "${_deliveryDate == null ? 'chưa chọn' : _formatDate(_deliveryDate!)}",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
