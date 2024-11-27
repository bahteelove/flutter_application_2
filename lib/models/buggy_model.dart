class Buggy {
  final int id;
  final String model;
  final String imageUrl;
  final int price;

  Buggy({
    required this.id,
    required this.model,
    required this.imageUrl,
    required this.price,
  });

  // Метод для преобразования объекта Buggy в Map (для отправки на сервер или сохранения локально)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  // Метод для преобразования Map в объект Buggy
  static Buggy fromMap(Map<String, dynamic> map) {
    return Buggy(
      id: map['id'],
      model: map['model'],
      imageUrl: map['imageUrl'],
      price: map['price'],
    );
  }
}
