import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/Buggy.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key, required this.buggy});

  final Buggy buggy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(buggy.model),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  buggy.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            Text(
              'PRice: ${buggy.price} usd',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            
          ],
        ));
  }
}