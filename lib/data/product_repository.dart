import 'package:untitled/data/models/product.dart';

/// Danh sách sản phẩm của cửa hàng.
const kProducts = <Product>[
  Product(
    id: 1,
    name: "iPhone 15",
    price: 999,
    discountPercent: 9,
    image: "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=600",
    description:
        "iPhone 15 màn hình 6.1 inch Super Retina XDR, chip A16 Bionic, "
        "camera kép 48MP và cổng USB-C. Máy mới nguyên seal, bảo hành 12 tháng.",
  ),
  Product(
    id: 2,
    name: "Samsung S24",
    price: 899,
    discountPercent: 10,
    image: "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600",
    description:
        "Galaxy S24 màn hình Dynamic AMOLED 120Hz, chip Snapdragon 8 Gen 3, "
        "pin 4000mAh sạc nhanh. Tích hợp nhiều tính năng AI cho chụp ảnh.",
  ),
  Product(
    id: 3,
    name: "MacBook Air",
    price: 1200,
    discountPercent: 7,
    image: "https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=600",
    description:
        "MacBook Air 13 inch chip M2, RAM 8GB, SSD 256GB. Thân nhôm mỏng nhẹ "
        "1.24kg, pin dùng tới 18 giờ, chạy êm vì không có quạt.",
  ),
  Product(
    id: 4,
    name: "iPad Pro",
    price: 1099,
    discountPercent: 12,
    image: "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600",
    description:
        "iPad Pro 11 inch chip M4, màn hình Ultra Retina XDR, hỗ trợ Apple "
        "Pencil Pro. Hợp cho vẽ, dựng phim và ghi chép.",
  ),
  Product(
    id: 5,
    name: "AirPods Pro 2",
    price: 249,
    discountPercent: 15,
    image: "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600",
    description:
        "Tai nghe chống ồn chủ động thế hệ 2, âm thanh không gian, hộp sạc "
        "USB-C. Thời lượng tổng cộng tới 30 giờ.",
  ),
  Product(
    id: 6,
    name: "Apple Watch S9",
    price: 399,
    image: "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600",
    description:
        "Apple Watch Series 9 chip S9, màn hình sáng 2000 nits, đo nhịp tim "
        "và nồng độ oxy trong máu. Chống nước 50m.",
  ),
];
