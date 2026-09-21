import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';

class ProductWidget extends StatelessWidget {
  static const double imageWidth = 300;
  static const double imageHeight = 200;

  final Product product;
  final VoidCallback? onAddToCart;

  const ProductWidget({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Ảnh luôn 300x200. Khi chỗ còn lại quá hẹp thì xếp dọc
            // thay vì ép chữ, để không mất thông tin và không tràn.
            final isWide = constraints.maxWidth >= imageWidth + 220;

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image(),
                  const SizedBox(width: 16),
                  Expanded(child: _info(centered: false)),
                ],
              );
            }

            // Hẹp: ảnh và chữ cùng căn giữa.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _image(),
                const SizedBox(height: 16),
                _info(centered: true),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      width: imageWidth,
      height: imageHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.image ?? "",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.image, size: 80),
            );
          },
        ),
      ),
    );
  }

  Widget _info({required bool centered}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          product.name,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Wrap để giá xuống dòng thay vì tràn khi chỗ quá hẹp.
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text("Price: "),
            Text(
              "${product.price}\$",
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "${(product.price * 0.8).round()}\$",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          product.description ?? "",
          textAlign: centered ? TextAlign.center : TextAlign.justify,
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onAddToCart,
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text("Thêm vào giỏ hàng"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
