import '/components/auth_service.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _fullName = 'Gavin Omalley';
  String _phone = '+1 1234 567 890';

  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  void _editProfile(String fullName, String phone) {
    setState(() {
      _fullName = fullName;
      _phone = phone;
    });
  }

  void _onMenuSelected(String value) {
    if (value == 'edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfilePage(
            fullName: _fullName,
            phone: _phone,
            onSave: _editProfile,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.edit, color: Colors.white),
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _fullName,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentEmail.toString(),
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _phone,
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
