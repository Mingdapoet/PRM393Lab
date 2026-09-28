import 'package:flutter/material.dart';
import 'package:untitled/data/models/coupon.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/widgets/product_card.dart';

/// Giỏ hàng: sửa số lượng, xoá món, nhập mã giảm giá và xem tổng tiền.
class CartPage extends StatefulWidget {
  /// Gọi khi giỏ rỗng và người dùng bấm "Tiếp tục mua sắm".
  final VoidCallback? onGoShopping;

  const CartPage({super.key, this.onGoShopping});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _codeController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    // TextEditingController phải dispose, nếu không sẽ rò rỉ bộ nhớ.
    _codeController.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    final cart = CartScope.of(context);
    final message = cart.applyCoupon(_codeController.text);

    setState(() => _error = message);

    if (message == null) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đã áp mã ${cart.coupon!.code}"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          if (!cart.isEmpty)
            TextButton(
              onPressed: () {
                cart.clear();
                _codeController.clear();
                setState(() => _error = null);
              },
              // Không đặt cứng màu chữ: AppBar sáng/tối đều đọc được.
              child: const Text("Xoá hết"),
            ),
        ],
      ),
      body: cart.isEmpty ? _emptyCart() : _cartContent(),
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 96,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text("Giỏ hàng đang trống", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: widget.onGoShopping,
            icon: const Icon(Icons.storefront),
            label: const Text("Tiếp tục mua sắm"),
          ),
        ],
      ),
    );
  }

  Widget _cartContent() {
    final cart = CartScope.of(context);

    return Column(
      children: [
        // Expanded giữ ListView trong chiều cao hữu hạn, phần tổng tiền
        // luôn nằm cố định phía dưới.
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              final product = item.product;

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ProductImage(
                          product: product,
                          width: 56,
                          height: 56,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${product.finalPrice}\$ x ${item.quantity} = "
                              "${item.subtotal}\$",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => cart.setQuantity(
                          product,
                          item.quantity - 1,
                        ),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text("${item.quantity}"),
                      IconButton(
                        onPressed: () => cart.setQuantity(
                          product,
                          item.quantity + 1,
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        _couponSection(),
        _totalSection(),
      ],
    );
  }

  Widget _couponSection() {
    final cart = CartScope.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _codeController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: "Mã giảm giá",
                    hintText: "VD: SALE10",
                    errorText: _error,
                    prefixIcon: const Icon(Icons.local_offer_outlined),
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _applyCoupon(),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _applyCoupon,
                child: const Text("Áp dụng"),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Gợi ý các mã đang có; bấm chip là điền sẵn vào ô nhập.
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final c in kCoupons)
                ActionChip(
                  label: Text(c.code),
                  tooltip: c.label,
                  onPressed: () {
                    _codeController.text = c.code;
                    _applyCoupon();
                  },
                ),
            ],
          ),

          if (cart.coupon != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Expanded(child: Text(cart.coupon!.label)),
                  TextButton(
                    onPressed: () {
                      cart.clearCoupon();
                      _codeController.clear();
                      setState(() => _error = null);
                    },
                    child: const Text("Bỏ mã"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _totalSection() {
    final cart = CartScope.of(context);

    return Material(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row("Tiền hàng", "${cart.subtotal}\$"),
            if (cart.discount > 0)
              _row(
                "Giảm giá (${cart.coupon!.code})",
                "-${cart.discount}\$",
                color: Colors.green,
              ),
            const Divider(),
            _row("Tổng cộng", "${cart.total}\$", isTotal: true),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  final total = cart.total;
                  cart.clear();
                  _codeController.clear();
                  setState(() => _error = null);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Đặt hàng thành công! Tổng $total\$"),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                icon: const Icon(Icons.payment),
                label: const Text("Thanh toán"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool isTotal = false,
    Color? color,
  }) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 15,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: color ?? (isTotal ? Colors.red : null),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: style.copyWith(color: color)),
          const Spacer(),
          Text(value, style: style),
        ],
      ),
    );
  }
}
