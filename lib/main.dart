import 'package:flutter/material.dart';

void main() {
  runApp(BuggiesStoreApp());
}

class BuggiesStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buggies Store',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // Customize your theme here
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> favorites = {};
  String selectedCategory = 'All';

  final List<Buggy> buggies = [
    Buggy(
      title: 'Dodge Challenger',
      manufacturer: 'Chervrolet',
      price: 25000.000,
      imageUrl: 'https://rightrent24.ru/upload/iblock/e15/arenda-dodge-challenger-1.webp',
      category: 'car',
      description: 'A high-performance buggy for racing.',
      quantity: 100,
    ),
    Buggy(
      title: 'Tesla S',
      manufacturer: 'Tesla',
      price: 25000.000,
      imageUrl: 'https://i.insider.com/60db6b321477f300188c85f7?width=1200&format=jpeg',
      category: 'car',
      description: 'An eco-friendly electric buggy for city rides.',
      quantity: 100,
    ),
    Buggy(
      title: 'Toyota Rav4',
      manufacturer: 'Toyota',
      price: 15000.99,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Toyota_RAV4_HYBRID_Adventure_%286AA-AXAH54-ANXVB%29_front.jpg/1200px-Toyota_RAV4_HYBRID_Adventure_%286AA-AXAH54-ANXVB%29_front.jpg',
      category: 'SUV',
      description: 'Perfect for family outings with spacious seating.',
      quantity: 100,
    ),
  ];

  List<Buggy> get filteredBuggies {
    if (selectedCategory == 'All') {
      return buggies;
    } else {
      return buggies.where((buggy) => buggy.category == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buggies', style: TextStyle(fontSize: 24.0)),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: <String>['All', 'car', 'SUV']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 18.0)),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBuggies.length,
              itemBuilder: (context, index) {
                final buggy = filteredBuggies[index];
                return BuggyItem(
                  buggy: buggy,
                  isFavorite: favorites.contains(buggy.title),
                  onFavoritePressed: () {
                    setState(() {
                      if (favorites.contains(buggy.title)) {
                        favorites.remove(buggy.title);
                      } else {
                        favorites.add(buggy.title);
                      }
                    });
                  },
                  onBuggyPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuggyDetailsScreen(buggy: buggy),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Buggy {
  final String title;
  final String manufacturer;
  final double price;
  final String imageUrl;
  final String category;
  final String description;
  final int quantity;

  Buggy({
    required this.title,
    required this.manufacturer,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.quantity,
  });
}

class BuggyItem extends StatelessWidget {
  final Buggy buggy;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onBuggyPressed;

  BuggyItem({
    required this.buggy,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onBuggyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4,
      child: InkWell(
        onTap: onBuggyPressed,
        child: Row(
          children: <Widget>[
            Image.network(
              buggy.imageUrl,
              width: 120, // Increased width
              height: 120, // Increased height
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Increased padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      buggy.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                    Text(
                      buggy.manufacturer,
                      style: TextStyle(
                        color: Colors.grey[700], // Darker grey
                        fontSize: 15.0, // Slightly increased font size
                      ),
                    ),
                    Text(
                      '\$${buggy.price}',
                      style: TextStyle(
                        fontSize: 20.0, // Increased font size
                        color: Colors.black, // Darker green
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
                size: 30, // Increased icon size
              ),
              onPressed: onFavoritePressed,
            ),
          ],
        ),
      ),
    );
  }
}

class BuggyDetailsScreen extends StatelessWidget {
  final Buggy buggy;

  BuggyDetailsScreen({required this.buggy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buggy.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              buggy.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    buggy.title,
                    style: TextStyle(
                      fontSize: 26.0, // Increased title size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Manufacturer: ${buggy.manufacturer}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \$${buggy.price}',
                    style: TextStyle(
                      fontSize: 22.0, // Increased price size
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    buggy.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Remaining units: ${buggy.quantity}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart'),
                        ),
                      );
                    },
                    
                    child: Text('Add to cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
