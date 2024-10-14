import 'package:flutter/material.dart';
import 'favorites.dart';
import 'dashboard.dart'; // นำเข้า Dashboard เพื่อนำทางไปยังหน้า Dashboard
import 'login.dart'; // นำเข้าหน้า Login

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteAnimals; // ตัวแปรรับข้อมูล

  const ProfilePage({super.key, required this.favoriteAnimals}); // รับข้อมูลใน constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/Lion.jpg'), // เปลี่ยนเป็นรูปภาพที่ต้องการ
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('สิ่งที่ถูกใจ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(favoriteAnimals: favoriteAnimals), // ส่งข้อมูลไปยัง FavoritesPage
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // การดำเนินการเมื่อกดที่การตั้งค่า
              },
            ),
            const Divider(), // เพิ่ม Divider เพื่อแยกส่วน
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // นำทางกลับไปยังหน้า Login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()), // เปลี่ยนเป็นหน้า Login
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
