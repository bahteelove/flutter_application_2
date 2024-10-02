import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Buggy.dart';
import '../models/cart.dart'; // Импорт модели корзины

class BuggyDetailScreen extends StatelessWidget {
  final Buggy buggy;

  BuggyDetailScreen({required this.buggy});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(buggy.model),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              buggy.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              buggy.model,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${buggy.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description please',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                cart.addItem(buggy);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${buggy.model} added to the cart!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('add to the cart'),
            ),
          ],
        ),
      ),
    );
  }
}