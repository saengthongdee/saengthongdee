import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  final String behavior;
  final String imagePath;

  const ShowData({
    Key? key,
    required this.name,
    required this.description,
    required this.location,
    required this.behavior,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // ให้ Scroll ได้เมื่อเนื้อหามีมาก
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // จัดซ้าย
            children: [
              // แสดงรูปภาพใน Card
              Card(
                elevation: 4, // เพิ่มเงา
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // มุมโค้ง
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // มุมโค้ง
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity, // เต็มความกว้าง
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ชื่อสัตว์
              Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // เปลี่ยนสีเป็นสีเข้ม
                ),
              ),
              const SizedBox(height: 10),
              // รายละเอียด
              _buildDetailSection('Description:', description),
              const SizedBox(height: 10),
              _buildDetailSection('Location:', location),
              const SizedBox(height: 10),
              _buildDetailSection('Behavior:', behavior),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันเพื่อแสดงรายละเอียด
  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // สีที่แตกต่าง
          ),
        ),
        Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.black54), // สีเทาอ่อน
        ),
      ],
    );
  }
}
