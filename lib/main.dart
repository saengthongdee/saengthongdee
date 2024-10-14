import 'package:flutter/material.dart';
import 'screen/login.dart';
import 'screen/dashboard.dart';


void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimalLandPage(),
    );
  }
}