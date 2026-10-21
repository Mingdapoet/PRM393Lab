import 'package:flutter/material.dart';
import 'package:untitled/data/models/account.dart';

/// Giữ trạng thái đăng nhập. Cách làm giống CartModel: đổi state thì
/// notifyListeners() để các màn hình đang nghe tự vẽ lại.
class AuthModel extends ChangeNotifier {
  Account? _user;

  /// Tài khoản đang đăng nhập, null nếu chưa đăng nhập.
  Account? get user => _user;

  bool get isLoggedIn => _user != null;

  /// Đăng nhập. Trả về null nếu thành công, ngược lại trả về lời báo lỗi.
  String? login(String username, String password) {
    final name = username.trim();

    for (final account in kAccounts) {
      if (account.username == name && account.password == password) {
        _user = account;
        notifyListeners();
        return null;
      }
    }
    // Không nói rõ sai username hay password để người lạ khó dò tài khoản.
    return "Sai tên đăng nhập hoặc mật khẩu.";
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}

/// Đưa AuthModel xuống cả cây widget, giống CartScope.
class AuthScope extends InheritedNotifier<AuthModel> {
  const AuthScope({super.key, required AuthModel auth, required super.child})
      : super(notifier: auth);

  static AuthModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthScope>();
    assert(scope != null, "Không tìm thấy AuthScope phía trên widget này.");
    return scope!.notifier!;
  }
}
