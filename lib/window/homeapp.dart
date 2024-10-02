import 'package:flutter/material.dart';
//import 'package:flutter_application_2/main.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/buggy_card.dart';
import '../models/Buggy.dart';

class HomeApp extends StatelessWidget {
  final List<Buggy> items = [
    Buggy(model: 'Mazda', imageUrl: 'https://di-uploads-pod17.dealerinspire.com/tulleymazda/uploads/2019/03/2019-mazda-cx-9-3-row-suv-back.jpg', price: 10000.99),
    Buggy(model: 'Chevy', imageUrl: 'https://static1.topspeedimages.com/wordpress/wp-content/uploads/2023/11/resize_download-1-1.jpeg', price: 20000.99),
    Buggy(model: 'Chevy', imageUrl: 'https://cdn.motor1.com/images/mgl/P3onNL/s1/2023-chevrolet-corvette-z06.jpg', price: 30000.99),
    Buggy(model: 'Audi', imageUrl: 'https://avatars.mds.yandex.net/get-verba/1535139/2a0000017f5901ab3c6c4f2b477b5bdf118e/cattouchret', price: 30000.99),
    Buggy(model: 'Dodge', imageUrl: 'https://www.dodge.com/content/dam/fca-brands/na/dodge/en_us/2023/challenger/gallery/exterior/MY23_Challenger_Gallery_07.jpg.image.1440.jpg', price: 30000.99)
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                cart.itemCount.toString(),
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 3,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, i) => BuggyCard(buggy: items[i]),
        ),
      ),
    );
  }
}