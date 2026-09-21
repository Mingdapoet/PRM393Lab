// Lab 4 - Exercise 1: Core Widgets (Text, Image, Icon, Card, ListTile)
//
// Mục tiêu: dựng một màn hình đơn giản thể hiện các widget hiển thị
// cơ bản nhất của Flutter.

import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  // Ảnh lấy từ dog.ceo - API ảnh miễn phí, không cần API key.
  static const _imageUrl =
      "https://images.dog.ceo/breeds/retriever-golden/n02099601_3004.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ex1 - Core Widgets")),
      // SingleChildScrollView: tránh tràn khi màn hình thấp.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Text dạng headline - lấy style từ theme cho nhất quán.
            Text(
              "Cửa hàng thú cưng",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            // 2. Icon từ bộ Material Icons.
            Row(
              children: [
                const Icon(Icons.pets, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                Text(
                  "Chó cảnh thuần chủng",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Image.network - ảnh tải từ Internet.
            // loadingBuilder hiện spinner lúc đang tải,
            // errorBuilder hiện icon thay thế nếu mất mạng.
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 64),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 4. Card bọc ListTile - mẫu hay gặp trong danh sách.
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.pets)),
                title: const Text("Golden Retriever"),
                subtitle: const Text("Thân thiện, thông minh, hợp gia đình"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bạn đã chọn Golden Retriever")),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.pets)),
                title: const Text("Siberian Husky"),
                subtitle: const Text("Năng động, lông dày, ưa vận động"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bạn đã chọn Siberian Husky")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
