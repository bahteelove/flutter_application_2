import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Services',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // alinging by center
            children: [
              ServiceItem(
                title: 'Porsche 911 GTR',
                price: 2000000,
                duration: '2-3 days',
              ),
              SizedBox(height: 20),
              ServiceItem(
                title: 'Chevy Challanger',
                price: 70000,
                duration: '2-3 days',
              ),
              SizedBox(height: 20),
              ServiceItem(
                title: 'Chevy Camaro',
                price: 25000,
                duration: '2-3 days',
              ),
              Spacer(),  // чтобы кнопки не убегали
            ],
          ),
        ),
      ),
    );
  }
}

// отображения услуги в каталоге
class ServiceItem extends StatelessWidget {
  final String title;
  final int price;
  final String duration;

  const ServiceItem({
    required this.title,
    required this.price,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 136,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    duration,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '$price usd',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  // добавления в корзину
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FirstPage(),
  ));
}