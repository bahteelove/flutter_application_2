import 'package:flutter/material.dart';
import 'car.dart';

class AddEditCarScreen extends StatefulWidget {
  final Function(Car) onSave;
  final Car? car;

  AddEditCarScreen({required this.onSave, this.car});

  @override
  _AddEditCarScreenState createState() => _AddEditCarScreenState();
}

class _AddEditCarScreenState extends State<AddEditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modelController;
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      _modelController = TextEditingController(text: widget.car!.model);
      _imageUrlController = TextEditingController(text: widget.car!.imageUrl);
      _priceController = TextEditingController(text: widget.car!.price.toString());
      _descriptionController = TextEditingController(text: widget.car!.description);
    } else {
      _modelController = TextEditingController();
      _imageUrlController = TextEditingController();
      _priceController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _modelController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveCar() {
    if (_formKey.currentState!.validate()) {
      final car = Car(
        id: widget.car?.id ?? 0, // ID будет 0, если машина новая
        model: _modelController.text,
        imageUrl: _imageUrlController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        description: _descriptionController.text,
      );
      widget.onSave(car);
      Navigator.pop(context, car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car == null ? 'Add Car' : 'Edit Car'),
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
                  if (value!.isEmpty) {
                    return 'Please enter a model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCar,
                child: Text(widget.car == null ? 'Add Car' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
