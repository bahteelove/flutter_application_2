import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String fullName;
  final String phone;
  final Function(String, String) onSave;

  const EditProfilePage({
    super.key,
    required this.fullName,
    required this.phone,
    required this.onSave,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Cell phone'),
              ),
              const SizedBox(height: 10),
              
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  widget.onSave(
                    _fullNameController.text,
                    _phoneController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
