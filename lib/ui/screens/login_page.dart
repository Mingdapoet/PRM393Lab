import 'package:flutter/material.dart';
import 'package:untitled/ui/auth_scope.dart';

/// Kiểm tra username: bắt buộc, 3-20 ký tự, chỉ gồm chữ, số và dấu _.
String? validateUsername(String? value) {
  final name = value?.trim() ?? "";
  if (name.isEmpty) return "Vui lòng nhập tên đăng nhập.";
  if (name.length < 3) return "Tên đăng nhập phải có ít nhất 3 ký tự.";
  if (name.length > 20) return "Tên đăng nhập tối đa 20 ký tự.";
  if (!RegExp(r"^[a-zA-Z0-9_]+$").hasMatch(name)) {
    return "Chỉ dùng chữ không dấu, số và dấu _.";
  }
  return null;
}

/// Kiểm tra password: bắt buộc, ít nhất 6 ký tự, không có khoảng trắng.
String? validatePassword(String? value) {
  final password = value ?? "";
  if (password.isEmpty) return "Vui lòng nhập mật khẩu.";
  if (password.length < 6) return "Mật khẩu phải có ít nhất 6 ký tự.";
  if (password.contains(" ")) return "Mật khẩu không được chứa khoảng trắng.";
  return null;
}

/// Màn hình đăng nhập: username, password và hai nút Cancel / Login.
class LoginPage extends StatefulWidget {
  /// Gọi khi bấm Cancel.
  final VoidCallback? onCancel;

  const LoginPage({super.key, this.onCancel});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  /// Lỗi từ phía tài khoản (sai username/password), khác lỗi validate.
  String? _loginError;

  /// Chưa bấm Login thì không báo lỗi; bấm rồi thì báo ngay khi gõ.
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _loginError = null);

    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }

    FocusScope.of(context).unfocus();
    final error = AuthScope.of(context).login(
      _usernameController.text,
      _passwordController.text,
    );
    if (error != null) {
      setState(() => _loginError = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Đăng nhập")),
      body: Center(
        // Cuộn được để bàn phím bật lên không làm tràn màn hình.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.storefront, size: 72, color: colors.primary),
                const SizedBox(height: 8),
                Text(
                  "Đăng nhập để mua sắm",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  validator: validateUsername,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: _hidePassword ? "Hiện mật khẩu" : "Ẩn mật khẩu",
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: validatePassword,
                ),
                if (_loginError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _loginError!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.error),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onCancel,
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _submit,
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Tài khoản thử: admin / 123456",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
