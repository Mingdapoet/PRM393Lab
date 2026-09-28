import 'package:flutter/material.dart';
import 'package:untitled/data/models/cart_item.dart';
import 'package:untitled/data/models/coupon.dart';
import 'package:untitled/data/models/product.dart';

/// Giữ toàn bộ state của giỏ hàng. Dùng ChangeNotifier để mọi màn hình
/// đang lắng nghe đều tự vẽ lại khi giỏ thay đổi.
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  Coupon? _coupon;

  List<CartItem> get items => List.unmodifiable(_items);
  Coupon? get coupon => _coupon;

  /// Tổng số sản phẩm (tính cả số lượng) - hiện trên badge của tab Cart.
  int get totalQuantity =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  /// Tiền hàng trước khi trừ mã giảm giá.
  int get subtotal => _items.fold(0, (sum, item) => sum + item.subtotal);

  /// Số tiền mã giảm giá trừ được cho đơn hiện tại.
  int get discount => _coupon?.discountFor(subtotal) ?? 0;

  int get total => subtotal - discount;

  bool get isEmpty => _items.isEmpty;

  /// Thêm sản phẩm; nếu đã có trong giỏ thì chỉ cộng dồn số lượng.
  void add(Product product, {int quantity = 1}) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product, quantity: quantity));
    } else {
      final current = _items[index];
      _items[index] = current.copyWith(quantity: current.quantity + quantity);
    }
    notifyListeners();
  }

  /// Đổi số lượng; về 0 thì bỏ khỏi giỏ luôn.
  void setQuantity(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  /// Áp mã. Trả về null nếu hợp lệ, ngược lại trả về lời nhắc lỗi.
  String? applyCoupon(String input) {
    final code = input.trim().toUpperCase();
    if (code.isEmpty) return "Bạn chưa nhập mã.";

    Coupon? found;
    for (final c in kCoupons) {
      if (c.code == code) {
        found = c;
        break;
      }
    }
    if (found == null) return "Mã \"$code\" không tồn tại.";

    if (subtotal < found.minTotal) {
      return "Đơn phải từ ${found.minTotal}\$ mới dùng được mã này.";
    }

    _coupon = found;
    notifyListeners();
    return null;
  }

  void clearCoupon() {
    _coupon = null;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _coupon = null;
    notifyListeners();
  }
}

/// Đưa CartModel xuống cả cây widget. Nhờ InheritedNotifier, widget nào
/// gọi CartScope.of(context) sẽ tự rebuild mỗi khi giỏ hàng đổi.
class CartScope extends InheritedNotifier<CartModel> {
  const CartScope({super.key, required CartModel cart, required super.child})
      : super(notifier: cart);

  static CartModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, "Không tìm thấy CartScope phía trên widget này.");
    return scope!.notifier!;
  }
}
