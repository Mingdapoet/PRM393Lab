import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/data/product_repository.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/widgets/product_card.dart';

/// Danh sách sản phẩm kèm ô tìm kiếm. Bấm vào một sản phẩm để xem chi tiết.
class HomePage extends StatefulWidget {
  /// Mở màn hình chi tiết của sản phẩm được chọn.
  final ValueChanged<Product>? onSelectProduct;

  /// Mở giỏ hàng khi bấm nút giỏ trên AppBar.
  final VoidCallback? onGoToCart;

  const HomePage({super.key, this.onSelectProduct, this.onGoToCart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _keyword = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Lọc theo tên, không phân biệt hoa thường.
  List<Product> get _visibleProducts {
    if (_keyword.isEmpty) return kProducts;
    final key = _keyword.toLowerCase();
    return kProducts
        .where((p) => p.name.toLowerCase().contains(key))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final products = _visibleProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          // Nút giỏ hàng: badge đỏ hiện số món đang có.
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge(
              isLabelVisible: cart.totalQuantity > 0,
              label: Text("${cart.totalQuantity}"),
              backgroundColor: Colors.red,
              child: IconButton(
                tooltip: "Giỏ hàng",
                onPressed: widget.onGoToCart,
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _keyword.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _keyword = "");
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                isDense: true,
              ),
              onChanged: (value) => setState(() => _keyword = value),
            ),
          ),

          // Expanded giữ ListView trong chiều cao hữu hạn của Column.
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text("Không tìm thấy sản phẩm nào."),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => widget.onSelectProduct?.call(product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
