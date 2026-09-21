import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 450,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.network(
                product.image ?? "",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 100);
                },
              ),
            ),
          ),
          Expanded(flex: 8, child: Text("Name: ${product.name}")),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Text("Price: "),
                Text(
                  "${product.price}\$",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(" ${(product.price * 0.8).round()}\$"),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              product.description ?? "",
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
