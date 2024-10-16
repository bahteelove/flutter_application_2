import 'Buggy.dart';
class CartItem {
  final Buggy buggy;
  int quantity;

  CartItem({required this.buggy, this.quantity = 1});
}