import 'package:flutter/material.dart';
import '../models/buggy_model.dart';
import '../window/buggydetailinfo.dart';

class BuggyCard extends StatelessWidget {
  final Buggy buggy;

  BuggyCard({required this.buggy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BuggyDetailScreen(buggy: buggy),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              
              child: Image.network(
                buggy.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    buggy.model,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$${buggy.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
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