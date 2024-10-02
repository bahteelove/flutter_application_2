import 'package:flutter/material.dart';

class BuggyDetailsScreen extends StatelessWidget {
  final String title;
  final String manufacturer;
  final double price;
  final String imageUrl;
  final String description;

  BuggyDetailsScreen({
    required this.title,
    required this.manufacturer,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imageUrl,
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
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Manufacturer: $manufacturer',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \$$price',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // add to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to the cart'),
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