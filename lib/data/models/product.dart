import 'dart:core';

class Product {
  final int id;
  final String name;
  final int price;
  final String? image;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
  });

  Product copyTo({
    int? id,
    String? name,
    String? image,
    int? price,
    String? description,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    image: image ?? this.image,
    description: description ?? this.description,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "description": description,
  };
}