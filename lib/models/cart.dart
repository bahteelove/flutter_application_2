import 'package:flutter/material.dart';
import 'Buggy.dart'; // Импорт модели продукта

class Cart with ChangeNotifier {
  final Map<String, Buggy> _items = {};

  Map<String, Buggy> get items {
    return {..._items};
  }

  // добавления товара в корзину
  void addItem(Buggy buggy) {
    _items.putIfAbsent(buggy.model, () => buggy);
    notifyListeners(); // Уведомляем, что состояние изменилось
  }

  //  удаления товара из корзины
  void removeItem(String model) {
    _items.remove(model);
    notifyListeners();
  }

  // Получение количества товаров в корзине
  int get itemCount {
    return _items.length;
  }
}