import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({Key? key, required this.imagePath, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imagePath),
        child: imagePath.isEmpty
            ? Icon(Icons.person, size: 50)
            : null,
      ),
    );
  }
}