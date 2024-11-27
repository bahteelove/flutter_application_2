// lib/screens/buggy_form_screen.dart
import 'package:flutter/material.dart';
import '../models/buggy_model.dart';

class BuggyFormScreen extends StatefulWidget {
  final Buggy? buggy; // Если передается объект для редактирования, иначе null

  BuggyFormScreen({Key? key, this.buggy}) : super(key: key);

  @override
  _BuggyFormScreenState createState() => _BuggyFormScreenState();
}

class _BuggyFormScreenState extends State<BuggyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _modelController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    // Если объект для редактирования передан, заполняем поля
    if (widget.buggy != null) {
      _modelController = TextEditingController(text: widget.buggy!.model);
      _imageUrlController = TextEditingController(text: widget.buggy!.imageUrl);
      _priceController = TextEditingController(text: widget.buggy!.price.toString());
    } else {
      // Если новый объект, инициализируем пустыми значениями
      _modelController = TextEditingController();
      _imageUrlController = TextEditingController();
      _priceController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _modelController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newBuggy = Buggy(
        id: widget.buggy?.id ?? DateTime.now().millisecondsSinceEpoch, // Если редактируем, оставляем id; если добавляем, генерируем новый id
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        price: int.parse(_priceController.text),
      );

      // Здесь можно вызвать функцию для отправки данных на сервер или сохранения локально
      print('Saving buggy: ${newBuggy.toJson()}');

      Navigator.of(context).pop(newBuggy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buggy == null ? 'Add Buggy' : 'Edit Buggy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(widget.buggy == null ? 'Add Buggy' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
