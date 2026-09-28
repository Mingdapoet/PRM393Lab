import 'dart:core';

class Product {
  final int id;
  final String name;
  final int price;
  final String? image;
  final String? description;

  /// Phần trăm giảm giá của riêng sản phẩm (0 = không giảm).
  final int discountPercent;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
    this.discountPercent = 0,
  });

  /// Giá sau khi trừ khuyến mãi của sản phẩm.
  int get finalPrice => (price * (100 - discountPercent) / 100).round();

  bool get hasDiscount => discountPercent > 0;

  Product copyTo({
    int? id,
    String? name,
    String? image,
    int? price,
    String? description,
    int? discountPercent,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    image: image ?? this.image,
    description: description ?? this.description,
    discountPercent: discountPercent ?? this.discountPercent,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
    // Dữ liệu cũ không có trường này -> mặc định 0.
    discountPercent: json["discountPercent"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "description": description,
    "discountPercent": discountPercent,
  };
}