import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sing In Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Sing In',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 194, 54),
        toolbarHeight: 30,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 220), // Отступ сверху
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'e-mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 10), // Отступ между полями
                    TextFormField(
                      decoration: InputDecoration(labelText: 'pass'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 10), // Отступ перед чекбоксом
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        Text('remember me'), // Уменьшено расстояние
                      ],
                    ),
                    SizedBox(height: 30), // Отступ перед кнопками
                    SizedBox(
                      width: double.infinity, // Устанавливаем ширину кнопки
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Логика аутентификации
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logging in...')),
                            );
                          }
                        },
                        child: Text('Log In'),
                      ),
                    ),
                    SizedBox(height: 30), // Отступ между кнопками
                    SizedBox(
                      width: double.infinity, // Устанавливаем ширину кнопки
                      child: ElevatedButton(
                        onPressed: () {
                          // Логика регистрации
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Navigating to Register...')),
                          );
                        },
                        child: Text('Sing In'),
                        style: ElevatedButton.styleFrom(
                        ),
                      ),
                    ),
                  SizedBox(height: 10), // Отступ перед текстовой кнопкой
                    TextButton(
                      onPressed: () {
                        // Логика восстановления пароля
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Navigating to Recover Password...')),
                        );
                      },
                      child: Text(
                        'recover the pass',
                        style: TextStyle(color: Colors.grey), // Цвет текста
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}