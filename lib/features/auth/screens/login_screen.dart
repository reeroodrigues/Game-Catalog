import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_catalog_app/features/auth/auth_provider.dart';
import '../data/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  String? _errorMessage;
  bool _loading = false;

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final auth = AuthRepository(ref.read(firebaseAuthProvider));
      if (_isLogin) {
        await auth.signIn(email, password);
      } else {
        await auth.register(email, password);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (_loading) const CircularProgressIndicator(),
                if (_errorMessage != null) ...[
                  Text(_errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Não tem uma conta? Cadastre-se'
                      : 'Já tem uma conta? Faça login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
