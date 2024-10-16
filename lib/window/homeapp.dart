import 'package:flutter/material.dart';
//import 'package:flutter_application_2/main.dart';

import '../models/cart.dart';
import '../widgets/buggy_card.dart';

import '../comps/item_note.dart';
import '../models/Buggy.dart';


final List<Buggy> buggies = [
  Buggy(id: 1, model: 'Mazda', imageUrl: 'https://di-uploads-pod17.dealerinspire.com/tulleymazda/uploads/2019/03/2019-mazda-cx-9-3-row-suv-back.jpg', price: 10000.99),
  Buggy(id: 2, model: 'Chevy', imageUrl: 'https://static1.topspeedimages.com/wordpress/wp-content/uploads/2023/11/resize_download-1-1.jpeg', price: 20000.99),
  Buggy(id: 3, model: 'Chevy', imageUrl: 'https://cdn.motor1.com/images/mgl/P3onNL/s1/2023-chevrolet-corvette-z06.jpg', price: 30000.99),
  Buggy(id: 4, model: 'Audi', imageUrl: 'https://avatars.mds.yandex.net/get-verba/1535139/2a0000017f5901ab3c6c4f2b477b5bdf118e/cattouchret', price: 30000.99),
  Buggy(id: 5, model: 'Dodge', imageUrl: 'https://www.dodge.com/content/dam/fca-brands/na/dodge/en_us/2023/challenger/gallery/exterior/MY23_Challenger_Gallery_07.jpg.image.1440.jpg', price: 30000.99),
];

class HomePage extends StatefulWidget {
  final Function(Buggy) onFavouriteToggle;
  final List<Buggy> favouriteBuggy;

  const HomePage({super.key, required this.onFavouriteToggle, required this.favouriteBuggy});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _addNewNoteDialog(BuildContext context) async {
    String model = '';
    String imageUrl = '';
    String price = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new car'),
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
                decoration: const InputDecoration(labelText: 'Image'),
                onChanged: (value){
                  imageUrl = value;
                }
              ),
              TextField(
                keyboardType: TextInputType.number,
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
                if (model.isNotEmpty && price.isNotEmpty && double.tryParse(price) != null) {
                  setState(() {
                    buggies.add(
                      Buggy(
                        id: buggies.length,
                        model: model,
                        imageUrl: imageUrl,
                        price: double.parse(price), // price is parsed correctly
                      ),
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$model added!')),
                  );
                  Navigator.of(context).pop();
                } else {
                  // Show error message if input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter valid details.')),
                  );
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
            return Dismissible(
              key: Key(buggyItem.id.toString()),
              onDismissed: (direction) {
                setState(() {
                  buggies.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${buggyItem.model} has been deleted')),
                );
              },
              background: Container(color: Colors.red),
              child: ItemNote(
                buggy: buggyItem,
                isFavourite: isFavourite,
                  onFavouriteToggle: () => widget.onFavouriteToggle(buggyItem)
              ),
            );
          },
        )
          : const Center(child: Text('Not available')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: FloatingActionButton(
            onPressed: () {
              _addNewNoteDialog(context);
            },
            backgroundColor: Colors.white.withOpacity(0.8),
            foregroundColor: Colors.white,
            splashColor: Colors.white60,
            elevation: 10.0,
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