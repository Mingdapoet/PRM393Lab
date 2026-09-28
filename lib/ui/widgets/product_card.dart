import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';

/// Thẻ sản phẩm trong danh sách: ảnh vuông bên trái, tên và giá ở giữa,
/// badge phần trăm giảm giá ở góc phải. Bấm vào thẻ để xem chi tiết.
class ProductCard extends StatelessWidget {
  static const double imageSize = 72;

  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ProductImage(
                  product: product,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              const SizedBox(width: 16),

              // Expanded để tên dài không đẩy badge ra ngoài màn hình.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    PriceTag(product: product),
                  ],
                ),
              ),

              if (product.hasDiscount) DiscountBadge(percent: product.discountPercent),
            ],
          ),
        ),
      ),
    );
  }
}

/// Giá gốc gạch ngang + giá sau giảm màu đỏ. Dùng Wrap để khi chỗ hẹp
/// thì giá xuống dòng thay vì tràn.
class PriceTag extends StatelessWidget {
  final Product product;
  final double fontSize;

  const PriceTag({super.key, required this.product, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        if (product.hasDiscount)
          Text(
            "${product.price}\$",
            style: TextStyle(
              fontSize: fontSize - 2,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          "${product.finalPrice}\$",
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Nhãn đỏ "-9%" ở góc thẻ.
class DiscountBadge extends StatelessWidget {
  final int percent;

  const DiscountBadge({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "-$percent%",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Ảnh sản phẩm tải từ mạng, có vòng chờ và ảnh thay thế khi lỗi mạng.
class ProductImage extends StatelessWidget {
  final Product product;
  final double? width;
  final double? height;

  const ProductImage({
    super.key,
    required this.product,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.image ?? "",
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported, size: 32),
      ),
    );
  }
}
