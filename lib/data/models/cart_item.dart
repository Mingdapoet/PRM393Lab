import 'package:untitled/data/models/product.dart';

/// Một dòng trong giỏ hàng: sản phẩm + số lượng đã chọn.
class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  /// Thành tiền của dòng này (đã tính khuyến mãi của sản phẩm).
  int get subtotal => product.finalPrice * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}
