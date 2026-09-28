import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/widgets/product_card.dart';

/// Màn hình chi tiết một sản phẩm: ảnh lớn, mô tả, chọn số lượng
/// rồi thêm vào giỏ hàng.
class ProductDetailPage extends StatefulWidget {
  final Product product;

  /// Gọi sau khi thêm vào giỏ, để màn hình cha chuyển sang tab Cart.
  final VoidCallback? onGoToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    this.onGoToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),

      // SingleChildScrollView để mô tả dài vẫn cuộn được, không tràn.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ProductImage(
                  product: product,
                  width: double.infinity,
                  height: 240,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (product.hasDiscount)
                  DiscountBadge(percent: product.discountPercent),
              ],
            ),
            const SizedBox(height: 8),

            PriceTag(product: product, fontSize: 22),
            const SizedBox(height: 16),

            const Text(
              "Mô tả",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              product.description ?? "Chưa có mô tả.",
              textAlign: TextAlign.justify,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 20),

            // --- Chọn số lượng ---
            Row(
              children: [
                const Text(
                  "Số lượng",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton.filledTonal(
                  onPressed: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "$_quantity",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Divider(height: 32),

            Row(
              children: [
                const Text("Tạm tính", style: TextStyle(fontSize: 16)),
                const Spacer(),
                Text(
                  "${product.finalPrice * _quantity}\$",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      cart.add(product, quantity: _quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Đã thêm $_quantity ${product.name} vào giỏ",
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("Thêm vào giỏ"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      cart.add(product, quantity: _quantity);
                      widget.onGoToCart?.call();
                    },
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text("Mua ngay"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
