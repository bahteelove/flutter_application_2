import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${cart.itemCount})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) {
                  final product = cart.items.values.toList()[i];
                  return ListTile(
                    leading: Image.network(product.imageUrl, width: 45),
                    title: Text(product.model),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cart.removeItem(product.model);
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Логика для завершения покупки
              },
              child: Text('Order'),
            ),
          ],
        ),
      ),
    );
  }
}