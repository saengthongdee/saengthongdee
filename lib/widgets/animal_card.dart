import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const AnimalCard({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // เมื่อกดจะเรียกฟังก์ชัน onTap
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover), // แสดงรูปภาพ
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
