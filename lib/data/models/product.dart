// Lab 1

class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String? description;

  // Const constructor
  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.description,
  });

  // Copy method (tương tự copyPerson)
  Product copyProduct({
    String? id,
    String? name,
    String? image,
    double? price,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}

void main() {
  // Ví dụ sử dụng - image chứa link ảnh
  Product p = const Product(
    id: "P01",
    name: "iPhone 15",
    image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-blue?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777972",
    price: 25000000,
    description: "Điện thoại cao cấp",
  );

  // Copy và thay đổi một số thông tin
  p = p.copyProduct(
    name: "iPhone 15 Pro Max",
    price: 32000000,
    image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1693009279096",
  );

  print("ID: ${p.id}");
  print("Name: ${p.name}");
  print("Image: ${p.image}");
  print("Price: ${p.price}");
  print("Description: ${p.description}");
}