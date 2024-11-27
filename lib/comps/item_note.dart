import 'package:flutter/material.dart';
import '../models/buggy_model.dart';
import '../window/catalog_page.dart';

class ItemNote extends StatelessWidget {
  final Buggy buggy;
  final bool isFavourite;
  final VoidCallback onFavouriteToggle;
  final VoidCallback onAddToCart;
  const ItemNote(
      {super.key, required this.buggy, required this.isFavourite, required this.onFavouriteToggle, required this.onAddToCart});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatalogPage(buggy: buggy),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(buggy.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          buggy.model,
                          style: const TextStyle(
                            fontSize: 27,
                            color: Colors.white,
                          ),
                        ),
                        
                        Text(
                          '${buggy.price} usd.',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.5,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.yellow,
                      ),
                      onPressed: onFavouriteToggle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 152, 149, 144),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add to the cart'),
            ),
          ],
        ),
      ),
    );
  }
}