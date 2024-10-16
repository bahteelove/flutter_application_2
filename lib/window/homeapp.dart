import 'package:flutter/material.dart';
//import 'package:flutter_application_2/main.dart';


import '../comps/item_note.dart';
import '../models/Buggy.dart';
import '../window/cart_page.dart';
import '../models/cart_item.dart';




final List<Buggy> buggies = [
  Buggy(id: 1, model: 'Mazda', imageUrl: 'https://di-uploads-pod17.dealerinspire.com/tulleymazda/uploads/2019/03/2019-mazda-cx-9-3-row-suv-back.jpg', price: 10000),
  Buggy(id: 2, model: 'Chevy', imageUrl: 'https://static1.topspeedimages.com/wordpress/wp-content/uploads/2023/11/resize_download-1-1.jpeg', price: 20000),
  Buggy(id: 3, model: 'Chevy', imageUrl: 'https://cdn.motor1.com/images/mgl/P3onNL/s1/2023-chevrolet-corvette-z06.jpg', price: 30000),
  Buggy(id: 4, model: 'Audi', imageUrl: 'https://avatars.mds.yandex.net/get-verba/1535139/2a0000017f5901ab3c6c4f2b477b5bdf118e/cattouchret', price: 30000),
  Buggy(id: 5, model: 'Dodge', imageUrl: 'https://www.dodge.com/content/dam/fca-brands/na/dodge/en_us/2023/challenger/gallery/exterior/MY23_Challenger_Gallery_07.jpg.image.1440.jpg', price: 30000),
];

class HomePage extends StatefulWidget {
  final Function(Buggy) onFavouriteToggle;
  final List<Buggy> favouriteBuggy;

  const HomePage({super.key, required this.onFavouriteToggle, required this.favouriteBuggy});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<CartItem> cart = [];

  void addToCart(Buggy buggy) {
    setState(() {
      final cartItemIndex = cart.indexWhere((item) => item.buggy.id == buggy.id);

      if (cartItemIndex != -1) {
        cart[cartItemIndex].quantity++;
      } else {
        cart.add(CartItem(buggy: buggy, quantity: 1));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${buggy.model} has been added'),)
    );
  }
  Future<void> _addNewNoteDialog(BuildContext context) async {
    String model = '';
    String imageUrl = '';
    String price = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('add new car'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Model'),
                onChanged: (value) {
                  model = value;
                },
              ),
              
              TextField(
                decoration: const InputDecoration(labelText: 'IMG'),
                onChanged: (value){
                  imageUrl = value;
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                onChanged: (value) {
                  price = value;
                },
              ),
              
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (model.isNotEmpty && price.isNotEmpty ) {
                  setState(() {
                    buggies.add(
                      Buggy(
                        id: buggies.length,
                        model: model,
                        imageUrl: imageUrl,
                        price: int.parse(price),
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buggy'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BasketPage(cart: cart)),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${cart.fold<int>(0, (previousValue, item) => previousValue + item.quantity)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        buggies.isNotEmpty
        ?GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: buggies.length,
          itemBuilder: (BuildContext context, int index) {
            final Buggy buggyItem = buggies[index];
            final isFavourite = widget.favouriteBuggy.contains(buggyItem);
            final DismissDirection dismissDirection =
            index % 2 == 0 ? DismissDirection.endToStart : DismissDirection.startToEnd;
            return Dismissible(
              key: Key(buggyItem.id.toString()),
              direction: dismissDirection,
              onDismissed: (direction) {
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          buggies.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${buggyItem.model} has been deleted')),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              child: ItemNote(
                buggy: buggyItem,
                isFavourite: isFavourite,
                  onFavouriteToggle: () => widget.onFavouriteToggle(buggyItem),
                onAddToCart: () => addToCart(buggyItem),
              ),
            );
          },
        )
          : const Center(child: Text('Not available')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: FloatingActionButton(
            onPressed: () {
              _addNewNoteDialog(context);
            },
            child: const Icon(
              Icons.add,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}