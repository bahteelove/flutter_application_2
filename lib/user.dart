import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Omalley',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '+1 234 456 6789',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'eeeeeeeeee@gmail.com',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Image.asset(
                '../assetsss/img/orders.png',
                width: 80,
                height: 40,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                    fontSize: 17,
                    ),
              ),
              onTap: () {
              },
            ),
            
            ListTile(
              leading: Image.asset(
                '../assetsss/img/delivery_point.png',
                width: 80,
                height: 40,
              ),
              title: Text(
                'Delivery points',
                style: TextStyle(
                    fontSize: 17,
                    ),
              ),
              onTap: () {
              },
            ),
            ListTile(
              leading: Image.asset(
                '../assetsss/img/settings.png',
                width: 80,
                height: 40,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 17)
              ),
              onTap: () {

              },
            ),

            SizedBox(height: 100),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Кнопка выхода
                    TextButton(
                      onPressed: () {
                        // выход из профиля
                      },
                      child: Text(
                        'Выход',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Profile(),
  ));
}