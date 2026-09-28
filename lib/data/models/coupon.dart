/// Mã giảm giá áp cho cả đơn hàng.
class Coupon {
  final String code;
  final String label;

  /// Giảm theo phần trăm (0 nếu mã này giảm số tiền cố định).
  final int percent;

  /// Giảm thẳng số tiền (0 nếu mã này giảm theo phần trăm).
  final int amount;

  /// Đơn phải đạt mức này mới dùng được mã.
  final int minTotal;

  const Coupon({
    required this.code,
    required this.label,
    this.percent = 0,
    this.amount = 0,
    this.minTotal = 0,
  });

  /// Số tiền được giảm, không bao giờ vượt quá giá trị đơn.
  int discountFor(int total) {
    if (total < minTotal) return 0;
    final value = percent > 0 ? (total * percent / 100).round() : amount;
    return value > total ? total : value;
  }
}

/// Danh sách mã đang có. Nhập mã ở màn hình Cart.
const kCoupons = <Coupon>[
  Coupon(
    code: "SALE10",
    label: "Giảm 10% toàn đơn",
    percent: 10,
  ),
  Coupon(
    code: "GIAM50",
    label: "Giảm 50\$ cho đơn từ 200\$",
    amount: 50,
    minTotal: 200,
  ),
  Coupon(
    code: "FREESHIP",
    label: "Giảm 20\$ phí giao hàng",
    amount: 20,
  ),
];
