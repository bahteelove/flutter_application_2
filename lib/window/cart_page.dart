import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class BasketPage extends StatefulWidget {
  final List<CartItem> cart;

  const BasketPage({super.key, required this.cart});

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int calculateTotalPrice() {
    int total = 0;
    for (var item in widget.cart) {
      total += (item.buggy.price) * item.quantity;
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      widget.cart[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (widget.cart[index].quantity > 1) {
        widget.cart[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index); // delete the item from the cart
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item has been deleted')),
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: widget.cart.isNotEmpty
          ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cart[index];

                return Dismissible(
                  key: Key(cartItem.buggy.id.toString()),
                  direction: DismissDirection.startToEnd, // swipe to right to delete
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  confirmDismiss: (direction) async {
                    
                    final confirm = await showDeleteConfirmationDialog(context);
                    if (confirm == true) {
                      removeItem(index); // 
                      return true;
                    }
                    return false;
                  },
                  child: ListTile(
                    leading: Image.network(
                      cartItem.buggy.imageUrl,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cartItem.buggy.model),
                    subtitle: Text('${cartItem.quantity} x ${cartItem.buggy.price} usd.'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => decreaseQuantity(index),
                        ),
                        Text(cartItem.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => increaseQuantity(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment has been done!')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: const Color.fromARGB(255, 76, 68, 58),
                foregroundColor: Colors.white,
              ),
              child: Text('Order for $totalPrice usd'),
            ),
          ),
        ],
      )
          : const Center(child: Text('The cart is empty')),
    );
  }
}