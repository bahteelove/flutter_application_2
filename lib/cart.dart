import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartItem(
              title: 'urus',
              price: 7000000,
              quantity: 1,
            ),
            SizedBox(height: 16),
            CartItem(
              title: 'ferrari',
              price: 18000000,
              quantity: 1,
            ),
            SizedBox(height: 20),

            // выравниевание total и price по краям контейнеров с услугами
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 20),
                  ),
                  Text(
                    '25000000 usd.',
                    style: TextStyle(
                        fontSize: 20),
                  ),
                ],
              ),
            ),

            Spacer(), // Отправляем кнопку вниз
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: Size(double.infinity, 50), 
              ),
              onPressed: () {
                //  оформления заказа
              },
              child: Text(
                'Go to order',
                style: TextStyle(
                    fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для отображения элемента в корзине
class CartItem extends StatelessWidget {
  final String title;
  final int price;
  final int quantity;

  const CartItem({
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title of the service
          Text(
            title,
            style: TextStyle(
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Цена
              Text(
                '$price usd.',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // Изменение количества и пациенты
              Row(
                children: [
                  // Пациенты
                  Text(
                    '$quantity patient${quantity > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // уменьшения количества
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // увеличения количества
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Cart(),
  ));
}