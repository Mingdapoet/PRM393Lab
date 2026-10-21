/// Tài khoản dùng để đăng nhập vào cửa hàng.
class Account {
  final String username;
  final String password;

  /// Tên hiện trên màn hình sau khi đăng nhập.
  final String displayName;

  const Account({
    required this.username,
    required this.password,
    required this.displayName,
  });
}

/// Tài khoản mẫu. Bài lab chưa có backend nên lưu cứng ở đây.
const kAccounts = <Account>[
  Account(username: "admin", password: "123456", displayName: "Admin"),
  Account(username: "minh", password: "minh123", displayName: "Minh"),
];
