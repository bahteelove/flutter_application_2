import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/Buggy.dart';
import 'package:flutter_application_2/window/catalog_page.dart';

class ItemNote extends StatelessWidget {
  final Buggy buggy;
  final bool isFavourite;
  final VoidCallback onFavouriteToggle;
  const ItemNote(
      {super.key, required this.buggy, required this.isFavourite, required this.onFavouriteToggle});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CatalogPage(buggy: buggy,)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(buggy.imageUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(16.0)),
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
                    style: const TextStyle(fontSize: 20),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue, width: 1)
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CatalogPage(buggy: buggy,)),
                      );
                    },
                    child: const Text('Car', style: TextStyle(fontSize: 15),),
                  ),
                  const SizedBox(height: 40),

                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.yellow,
                ),
                onPressed: onFavouriteToggle,
              ),
            )
          ]),
        ));
  }
}