import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/ui/widgets/product_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _product = Product(
    id: 1,
    name: "Golden Retriever",
    price: 1200,
    image:
        "https://images.dog.ceo/breeds/retriever-golden/n02099601_3004.jpg",
    description:
        "Giống chó Golden Retriever thuần chủng, thân thiện và thông minh, "
        "rất hợp với gia đình có trẻ nhỏ. Đã tiêm phòng đầy đủ.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const Icon(Icons.menu),
        title: const Text("Home page"),
        actions: [TextButton(onPressed: () {}, child: const Text("Login"))],
      ),
      body: const Center(child: ProductWidget(product: _product)),
    );
  }
}
