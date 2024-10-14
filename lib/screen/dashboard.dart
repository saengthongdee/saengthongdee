import 'package:flutter/material.dart';
import '../API/createAPI.dart';
import 'dart:convert';

class AnimalLandPage extends StatefulWidget {
  const AnimalLandPage({Key? key}) : super(key: key);

  @override
  State<AnimalLandPage> createState() => _AnimalLandPageState();
}

class _AnimalLandPageState extends State<AnimalLandPage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> animals = [];

  @override
  void initState() {
    super.initState();
    _loadAnimals();
  }

  void _loadAnimals() {
    AnimalApi api = AnimalApi();
    String jsonAnimals = api.getAnimalsJson();

    setState(() {
      animals = List<Map<String, dynamic>>.from(jsonDecode(jsonAnimals));
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredAnimals = animals.where((animal) {
      return animal['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Animal Land',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Additional menu options
            },
            tooltip: 'Menu',
          ),
        ],
        elevation: 10,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAnimals.length,
                itemBuilder: (context, index) {
                  return AnimalCard(
                    name: filteredAnimals[index]['name'] ?? 'Unknown',
                    imagePath: filteredAnimals[index]['imagePath'] ?? 'assets/placeholder.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowData(
                            name: filteredAnimals[index]['name'] ?? 'Unknown',
                            description: filteredAnimals[index]['description'] ?? 'No description available',
                            location: filteredAnimals[index]['location'] ?? 'Unknown location',
                            behavior: filteredAnimals[index]['behavior'] ?? 'No behavior information available', 
                            imagePath: filteredAnimals[index]['imagePath'] ?? 'assets/placeholder.jpg',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
  child: Container(
    height: 70,  // Adjust the height for proper spacing
    child: Center(
      child: Container(
        width: 60,  // Set the width and height to make it circular
        height: 60,
        decoration: BoxDecoration(
          color: Colors.green,  // Set the background color
          shape: BoxShape.circle,  // Makes the container circular
        ),
        child: IconButton(
          icon: const Icon(Icons.home),
          color: Colors.white,
          iconSize: 30,  // Adjust icon size if needed
          onPressed: () {
            // Handle button press
          },
        ),
      ),
    ),
  ),
),

    );
  }
}

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
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _buildInfoSection('Description:', description),
              const SizedBox(height: 20),
              _buildInfoSection('Location:', location),
              const SizedBox(height: 20),
              _buildInfoSection('Behavior:', behavior),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

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
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: AspectRatio(
                aspectRatio: 2.75 / 1.75,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
