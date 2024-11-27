import 'package:flutter/material.dart';
import 'add_edit_car_screen.dart';
import 'car.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  List<Car> cars = [
    // Пример с локальными изображениями:
    Car(
      id: 1,
      model: "BMW X5",
      imageUrl: "assets/images/bmw_x5.jpg", // Локальное изображение
      price: 50000,
      description: "A luxurious SUV with great performance.",
    ),
    // Пример с изображением из интернета:
    Car(
      id: 2,
      model: "Tesla Model S",
      imageUrl: "https://example.com/tesla_model_s.jpg", // Замените на реальный URL
      price: 80000,
      description: "An electric vehicle with cutting-edge technology.",
    ),
  ];

  int nextId = 1;

  void _addCar(Car car) {
    setState(() {
      cars.add(car);
      nextId++;
    });
  }

  void _editCar(int id, Car updatedCar) {
    setState(() {
      int index = cars.indexWhere((car) => car.id == id);
      if (index != -1) {
        cars[index] = updatedCar;
      }
    });
  }

  void _navigateToAddCarScreen(BuildContext context) async {
    final Car? newCar = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditCarScreen(
          onSave: _addCar,
          car: null,
        ),
      ),
    );
    if (newCar != null) {
      _addCar(newCar);
    }
  }

  void _navigateToEditCarScreen(BuildContext context, Car car) async {
    final Car? updatedCar = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditCarScreen(
          onSave: (Car car) => _editCar(car.id, car),
          car: car,
        ),
      ),
    );
    if (updatedCar != null) {
      _editCar(car.id, updatedCar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car List'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Количество колонок
          crossAxisSpacing: 10.0, // Пространство между колонками
          mainAxisSpacing: 10.0, // Пространство между строками
          childAspectRatio: 0.7, // Коэффициент ширины и высоты элемента
        ),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            onTap: () => _navigateToEditCarScreen(context, car),
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Проверка, если это локальное изображение
                  car.imageUrl.startsWith('http')
                      ? Image.network(
                          car.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.expectedTotalBytes! / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error, color: Colors.red)); // Иконка ошибки
                          },
                        )
                      : Image.asset(
                          car.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      car.model,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${car.price}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddCarScreen(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
