import '/pages/basket_page.dart';
import '/pages/favorite.dart';
import '/pages/login_page.dart';
import '/pages/profile.dart';
import 'package:flutter/material.dart';
import 'models/note.dart';
import 'pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(url: 'https://rklhmudyhvzfujxxptbr.supabase.co' , anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJrbGhtdWR5aHZ6ZnVqeHhwdGJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3NzIzMjgsImV4cCI6MjA0ODM0ODMyOH0.fz_kbVmqbPj-cpubfBZbIokZoAlkT49ffx0bBzGXCVo');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Вкусняшки',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Set<Sweet> favoriteSweets = <Sweet>{};
  Set<Sweet> basketItems = <Sweet>{};
  bool _isLoggedIn = false;

  static const List<Widget> _widgetTitles = [
    Text('Главная'),
    Text('Избранное'),
    Text('Корзина'),
    Text('Профиль'),
  ];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();

    _widgetOptions = <Widget>[
      HomePage(
        favoriteSweets: favoriteSweets,
        onFavoriteChanged: _onFavoriteChanged,
        onAddToBasket: _addToBasket,
      ),
      FavoritePage(
        favoriteSweets: favoriteSweets,
        onFavoriteChanged: _onFavoriteChanged,
      ),
      BasketPage(
        basketItems: basketItems,
        onRemoveFromBasket: _removeFromBasket,
      ),
      _isLoggedIn ? const ProfilePage() : const LoginPage(),
    ];

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      setState(() {
        _isLoggedIn = session != null;
        _widgetOptions[3] = _isLoggedIn ? const ProfilePage() : const LoginPage();
      });
    });
  }

  Future<void> _checkAuthStatus() async {
    final session = Supabase.instance.client.auth.currentSession;
    setState(() {
      _isLoggedIn = session != null;
    });
  }

  void _onFavoriteChanged(Sweet sweet, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        favoriteSweets.add(sweet);
      } else {
        favoriteSweets.remove(sweet);
      }
    });
  }

  void _addToBasket(Sweet sweet) {
    setState(() {
      basketItems.add(sweet);
    });
  }

  void _removeFromBasket(Sweet sweet) {
    setState(() {
      basketItems.remove(sweet);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 20, 137, 55),
        unselectedItemColor: const Color.fromARGB(255, 20, 137, 55),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
