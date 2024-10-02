import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'window/homeapp.dart';
import 'window/cartapp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Cart(),
      child: MaterialApp(
        title: 'Run Buggy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeApp(),
        routes: {
          '/cart': (ctx) => CartApp(), // Маршрут для страницы корзины
        },
      ),
    );
  }
}