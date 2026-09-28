// Lab 4 - Exercise 5: Debug & Fix Common UI Errors
//
// Bốn lỗi layout/state hay gặp nhất, mỗi lỗi ghi rõ:
// nguyên nhân -> cách sửa -> code đã sửa chạy được.

import 'package:flutter/material.dart';

class DebugFixDemo extends StatefulWidget {
  const DebugFixDemo({super.key});

  @override
  State<DebugFixDemo> createState() => _DebugFixDemoState();
}

class _DebugFixDemoState extends State<DebugFixDemo> {
  int _count = 0;
  DateTime? _picked;

  // ---------------------------------------------------------------
  // LỖI 3: state không cập nhật vì thiếu setState()
  //
  // SAI:   void _increment() { _count++; }
  //        -> biến đổi giá trị nhưng Flutter không biết để vẽ lại,
  //           màn hình vẫn hiện số cũ.
  // ĐÚNG:  bọc trong setState() để báo framework rebuild.
  // ---------------------------------------------------------------
  void _increment() {
    setState(() => _count++);
  }

  // ---------------------------------------------------------------
  // LỖI 4: DatePicker gọi sai BuildContext
  //
  // SAI:   gọi showDatePicker() ngay trong build(), hoặc dùng context
  //        chưa có Navigator/MaterialApp phía trên
  //        -> "No MaterialLocalizations found" hoặc mở lặp vô hạn.
  // ĐÚNG:  gọi từ callback (onPressed) với context của State,
  //        lúc này cây widget đã dựng xong và có Navigator hợp lệ.
  // ---------------------------------------------------------------
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    // Sau await, widget có thể đã bị gỡ khỏi cây -> phải kiểm tra mounted
    // trước khi setState, nếu không sẽ ném lỗi.
    if (!mounted) return;
    if (result != null) {
      setState(() => _picked = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ex5 - Debug & Fix")),
      // -------------------------------------------------------------
      // LỖI 2: tràn màn hình nhỏ
      //
      // SAI:   Column chứa nhiều nội dung, màn thấp -> RenderFlex
      //        overflowed by N pixels, sọc vàng-đen ở mép.
      // ĐÚNG:  bọc SingleChildScrollView để cuộn được.
      // -------------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Fix 1 =====
            const _FixCard(
              number: 1,
              title: "ListView bên trong Column",
              problem:
                  "Column cho con chiều cao vô hạn, ListView lại cần chiều "
                  "cao hữu hạn -> 'Vertical viewport was given unbounded height'.",
              solution:
                  "Bọc ListView trong Expanded (hoặc đặt chiều cao cụ thể "
                  "bằng SizedBox).",
              code: "Column(children: [\n"
                  "  Text('Tiêu đề'),\n"
                  "  Expanded(child: ListView(...)),  // <- fix\n"
                  "])",
            ),
            // Demo chạy thật: ListView có chiều cao xác định.
            SizedBox(
              height: 120,
              child: ListView(
                children: const [
                  ListTile(dense: true, title: Text("Mục 1")),
                  ListTile(dense: true, title: Text("Mục 2")),
                  ListTile(dense: true, title: Text("Mục 3")),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ===== Fix 2 =====
            const _FixCard(
              number: 2,
              title: "Tràn màn hình nhỏ",
              problem:
                  "Nội dung cao hơn màn hình -> 'A RenderFlex overflowed by "
                  "N pixels', hiện sọc vàng-đen.",
              solution:
                  "Bọc SingleChildScrollView để cuộn. Với Row thì dùng "
                  "Expanded/Flexible, hoặc Wrap để xuống dòng.",
              code: "SingleChildScrollView(  // <- fix\n"
                  "  child: Column(children: [...]),\n"
                  ")",
            ),
            const SizedBox(height: 16),

            // ===== Fix 3 =====
            const _FixCard(
              number: 3,
              title: "State không cập nhật",
              problem:
                  "Gán _count++ trực tiếp thì giá trị có đổi nhưng UI không "
                  "vẽ lại, màn hình vẫn hiện số cũ.",
              solution: "Bọc trong setState() để báo Flutter rebuild widget.",
              code: "// Sai:  _count++;\n"
                  "setState(() => _count++);  // <- fix",
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text("Đếm: $_count",
                        style: const TextStyle(fontSize: 18)),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _increment,
                      child: const Text("Tăng"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== Fix 4 =====
            const _FixCard(
              number: 4,
              title: "DatePicker sai BuildContext",
              problem:
                  "Gọi showDatePicker() trong build() hoặc với context không "
                  "có MaterialApp phía trên -> 'No MaterialLocalizations found'.",
              solution:
                  "Gọi từ callback (onPressed) với context của State. Sau "
                  "await phải kiểm tra mounted trước khi setState.",
              code: "onPressed: () async {\n"
                  "  final d = await showDatePicker(context: context, ...);\n"
                  "  if (!mounted) return;  // <- fix\n"
                  "  if (d != null) setState(() => _picked = d);\n"
                  "}",
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _picked == null
                            ? "Chưa chọn ngày"
                            : "Đã chọn: ${_picked!.day}/${_picked!.month}/${_picked!.year}",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _pickDate,
                      child: const Text("Chọn ngày"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Thẻ mô tả một lỗi: vấn đề, cách sửa, và đoạn code minh hoạ.
class _FixCard extends StatelessWidget {
  final int number;
  final String title;
  final String problem;
  final String solution;
  final String code;

  const _FixCard({
    required this.number,
    required this.title,
    required this.problem,
    required this.solution,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.red.shade100,
                  child: Text("$number"),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("Lỗi: $problem"),
            const SizedBox(height: 4),
            Text("Sửa: $solution"),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              // Code dài -> cho cuộn ngang thay vì tràn.
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  code,
                  style: const TextStyle(fontFamily: "monospace", fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
