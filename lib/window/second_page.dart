import 'package:flutter/material.dart';
import '../comps/item_note.dart';
import '../models/Buggy.dart';


class SecondPage extends StatelessWidget {
  final List<Buggy> favouriteBuggy;
  final Function(Buggy) onFavouriteToggle;
  final Function(Buggy) onAddToCart;

  const SecondPage(
      {super.key,
      required this.favouriteBuggy,
      required this.onFavouriteToggle,
      required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favouriteBuggy.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: favouriteBuggy.length,
                itemBuilder: (BuildContext context, int index) {
                  final buggy = favouriteBuggy[index];
                  return ItemNote(
                    buggy: buggy,
                    isFavourite: true,
                    onFavouriteToggle: () {
                      onFavouriteToggle(buggy);
                    },
                    onAddToCart:() {
                      onAddToCart(buggy);
                    },

                  );
                },
              )
            : const Center(
                child: Text('NOthing there yet'),
              ),
      ),
    );
  }
}