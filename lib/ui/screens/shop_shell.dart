import 'package:flutter/material.dart';
import 'package:untitled/data/models/product.dart';
import 'package:untitled/data/product_repository.dart';
import 'package:untitled/ui/cart_scope.dart';
import 'package:untitled/ui/screens/cart_page.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/screens/product_detail_page.dart';

/// Khung chính của app: 3 tab Home / Product Detail / Cart.
///
/// Dùng IndexedStack thay vì Navigator.push để mỗi tab giữ nguyên state
/// khi chuyển qua lại (ô tìm kiếm, số lượng đang chọn, mã giảm giá).
class ShopShell extends StatefulWidget {
  const ShopShell({super.key});

  @override
  State<ShopShell> createState() => _ShopShellState();
}

class _ShopShellState extends State<ShopShell> {
  int _tabIndex = 0;

  /// Sản phẩm đang xem ở tab Product Detail.
  Product _selected = kProducts.first;

  void _openDetail(Product product) {
    setState(() {
      _selected = product;
      _tabIndex = 1;
    });
  }

  void _goToTab(int index) => setState(() => _tabIndex = index);

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: [
          HomePage(
            onSelectProduct: _openDetail,
            onGoToCart: () => _goToTab(2),
          ),
          ProductDetailPage(
            // Key theo id để đổi sản phẩm thì số lượng đếm lại từ 1,
            // không giữ số của sản phẩm xem trước đó.
            key: ValueKey(_selected.id),
            product: _selected,
            onGoToCart: () => _goToTab(2),
          ),
          CartPage(onGoShopping: () => _goToTab(0)),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: _goToTab,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: "Product Detail",
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: cart.totalQuantity > 0,
              label: Text("${cart.totalQuantity}"),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: cart.totalQuantity > 0,
              label: Text("${cart.totalQuantity}"),
              child: const Icon(Icons.shopping_cart),
            ),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
