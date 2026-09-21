import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/ui/widgets/product_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _products = [
    Product(
      id: 1,
      name: "Golden Retriever",
      price: 1200,
      image:
          "https://images.dog.ceo/breeds/retriever-golden/n02099601_3004.jpg",
      description:
          "Giống chó Golden Retriever thuần chủng, thân thiện và thông minh, "
          "rất hợp với gia đình có trẻ nhỏ. Đã tiêm phòng đầy đủ.",
    ),
    Product(
      id: 2,
      name: "Siberian Husky",
      price: 1500,
      image: "https://images.dog.ceo/breeds/husky/n02110185_1469.jpg",
      description:
          "Husky Siberia lông dày, mắt xanh, năng động và ưa vận động. "
          "Phù hợp với người có nhiều thời gian dắt đi dạo.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text("Home page"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Login", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final p in _products)
            ProductWidget(
              product: p,
              onAddToCart: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đã thêm ${p.name} vào giỏ hàng"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
