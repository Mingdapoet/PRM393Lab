import 'package:flutter/material.dart';
import 'data/models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tạo thử 1 sản phẩm
    final product = Product(
      id: '1',
      name: 'iPhone 16',
      image: 'https://example.com/iphone.jpg',
      price: 24990000,
      description: 'Điện thoại cao cấp của Apple',
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test Product')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${product.id}', style: const TextStyle(fontSize: 18)),
              Text('Tên: ${product.name}', style: const TextStyle(fontSize: 18)),
              Text('Giá: ${product.price}', style: const TextStyle(fontSize: 18)),
              Text('Mô tả: ${product.description}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}