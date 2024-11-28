import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Dealership',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarsListScreen(),
    );
  }
}

class CarsListScreen extends StatefulWidget {
  const CarsListScreen({super.key});

  @override
  _CarsListScreenState createState() => _CarsListScreenState();
}

class _CarsListScreenState extends State<CarsListScreen> {
  List<dynamic> cars = [];
  bool isLoading = true;
  String errorMessage = '';
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    try {
      final response = await _dio.get('http://localhost:8080/cars');
      if (response.statusCode == 200) {
        setState(() {
          cars = response.data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load cars';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching cars: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Количество столбцов
                    childAspectRatio: 0.75, // Соотношение сторон элементов
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailScreen(car: cars[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cars[index]['brand'] + ' ' + cars[index]['model'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${cars[index]['price']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final dynamic car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['brand'] + ' ' + car['model']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand: ${car['brand']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Model: ${car['model']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Price: \$${car['price']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Year: ${car['year']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Description: ${car['description']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Availability: ${car['isAvailable'] ? 'Available' : 'Not Available'}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
