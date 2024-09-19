import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Авторизуйтесь',
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
            'Авторизация',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 54, 189, 194),
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
                          return 'Пожалуйста, введите свой логин';
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
                          return 'Пожалуйста, введите свой пароль';
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
                        Text('Запомнить меня'), // Уменьшено расстояние
                      ],
                    ),
                    SizedBox(height: 5), // Отступ перед кнопками
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
                        child: Text('Войти'),
                      ),
                    ),
                    SizedBox(height: 5), // Отступ между кнопками
                    SizedBox(
                      width: double.infinity, // Устанавливаем ширину кнопки
                      child: ElevatedButton(
                        onPressed: () {
                          // Логика регистрации
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Navigating to Register...')),
                          );
                        },
                        child: Text('Зарегистрироваться'),
                        style: ElevatedButton.styleFrom(
                        ),
                      ),
                    ),
                  SizedBox(height: 10), // Отступ перед текстовой кнопкой
                    TextButton(
                      onPressed: () {
                        // Логика восстановления пароля
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Переход в сброс пароля...')),
                        );
                      },
                      child: Text(
                        'Сброс пароля',
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