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
