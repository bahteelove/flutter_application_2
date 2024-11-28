import 'package:flutter/material.dart';

import '../components/auth_service.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;


    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("wrong passes")));
      return;
    }


    try {
      await authService.signUpWithEmailPassword(email, password);

      Navigator.pop(context);
    }

    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sing Up")),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "pass"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: "repeat pass"),
              obscureText: true,
            ),


            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: signUp,
              child: const Text("sing up"),
            ),




          ],
        )
    );
  }
}