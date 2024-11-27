import 'package:flutter/material.dart';
import '../models/buggy_model.dart';

class AddBuggyScreen extends StatefulWidget {
  @override
  _AddBuggyScreenState createState() => _AddBuggyScreenState();
}

class _AddBuggyScreenState extends State<AddBuggyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _saveBuggy() {
    if (_formKey.currentState!.validate()) {
      final newBuggy = Buggy(
        id: DateTime.now().millisecondsSinceEpoch,  // Генерация уникального ID
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        price: int.parse(_priceController.text),
      );

      // Здесь вы можете добавить код для сохранения нового объекта Buggy, например, через Dio или локальную базу данных

      // Для примера, выведем данные в консоль
      print('New Buggy Added: ${newBuggy.toMap()}');

      // Закрытие экрана после добавления
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Buggy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBuggy,
                child: Text('Save Buggy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditBuggyScreen extends StatefulWidget {
  final Buggy buggy;

  EditBuggyScreen({required this.buggy});

  @override
  _EditBuggyScreenState createState() => _EditBuggyScreenState();
}

class _EditBuggyScreenState extends State<EditBuggyScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modelController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.buggy.model);
    _imageUrlController = TextEditingController(text: widget.buggy.imageUrl);
    _priceController = TextEditingController(text: widget.buggy.price.toString());
  }

  void _updateBuggy() {
    if (_formKey.currentState!.validate()) {
      final updatedBuggy = Buggy(
        id: widget.buggy.id, // Оставляем тот же id для обновления
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        price: int.parse(_priceController.text),
      );

      // Здесь добавьте код для обновления Buggy, например, через Dio или локальную базу данных

      // Для примера, выведем данные в консоль
      print('Buggy Updated: ${updatedBuggy.toMap()}');

      // Закрытие экрана после обновления
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Buggy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateBuggy,
                child: Text('Update Buggy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuggyListScreen extends StatelessWidget {
  final List<Buggy> buggies = [
    Buggy(id: 1, model: 'Buggy A', imageUrl: 'url1', price: 100),
    Buggy(id: 2, model: 'Buggy B', imageUrl: 'url2', price: 200),
    // Добавьте другие объекты Buggy
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buggy List'),
      ),
      body: ListView.builder(
        itemCount: buggies.length,
        itemBuilder: (context, index) {
          final buggy = buggies[index];
          return ListTile(
            title: Text(buggy.model),
            subtitle: Text('\$${buggy.price}'),
            leading: Image.network(buggy.imageUrl),
            onTap: () {
              // Открытие экрана для редактирования выбранного Buggy
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBuggyScreen(buggy: buggy),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Открытие экрана для добавления нового Buggy
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBuggyScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
