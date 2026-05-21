import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../network/auth_service.dart'; // Убедись, что путь к нашему сервису верный

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Контроллеры для считывания текста из полей
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Инициализируем наш Firebase-сервис
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Общая функция для входа и регистрации
  Future<void> _submit(bool isLogin) async {
    // 1. Проверяем, что поля не пустые
    if (!_formKey.currentState!.validate()) return;

    // 2. Включаем крутилку загрузки
    setState(() => _isLoading = true);

    final email = _emailController.text;
    final password = _passwordController.text;

    // 3. Обращаемся к Firebase
    final result = isLogin
        ? await _authService.login(email, password)
        : await _authService.register(email, password);

    if (!mounted) return;

    // 4. Выключаем крутилку загрузки
    setState(() => _isLoading = false);

    if (result == null) {
      // ОШИБКА: Firebase вернул null (неверный пароль или почта занята)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ошибка авторизации. Проверьте email и пароль.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // УСПЕХ: Пользователь авторизован! Пускаем внутрь приложения
      context.go('/learn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor, // Фирменный синий фон
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- ЛОГОТИП / НАЗВАНИЕ ---
                  Text(
                    'Langly',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- ПОЛЕ ДЛЯ EMAIL ---
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- ПОЛЕ ДЛЯ ПАРОЛЯ ---
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- КНОПКИ ИЛИ ИНДИКАТОР ЗАГРУЗКИ ---
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () => _submit(true), // true = логин
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () => _submit(false), // false = регистрация
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Theme.of(context).primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}