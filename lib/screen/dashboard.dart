import 'package:flutter/material.dart';
import '../API/createAPI.dart';
import 'dart:convert';
import 'profile.dart'; // Import the Profile page
import '../widgets/animal_card.dart';
import 'showdata.dart';

class AnimalLandPage extends StatefulWidget {
  const AnimalLandPage({Key? key}) : super(key: key);

  @override
  State<AnimalLandPage> createState() => _AnimalLandPageState();
}

class _AnimalLandPageState extends State<AnimalLandPage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> animals = [];
  List<Map<String, dynamic>> favoriteAnimals = []; // List of favorite animals

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
                  bool isFavorite = favoriteAnimals.contains(filteredAnimals[index]);
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10), // Add vertical padding
                    leading: Container(
                      width: 70, // Set width to make it square
                      height: 70, // Set height to make it square
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                        image: DecorationImage(
                          image: AssetImage(filteredAnimals[index]['imagePath'] ?? 'assets/placeholder.jpg'),
                          fit: BoxFit.cover, // Cover the container while maintaining aspect ratio
                        ),
                      ),
                    ),
                    title: Text(filteredAnimals[index]['name'] ?? 'Unknown'),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoriteAnimals.remove(filteredAnimals[index]);
                          } else {
                            favoriteAnimals.add(filteredAnimals[index]);
                          }
                        });
                      },
                    ),
                    onTap: () {
                      // Navigate to ShowData page
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
          height: 70, // Adjust the height for proper spacing
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space evenly
            children: [
              // Home button
              Container(
                width: 60, // Set the width and height to make it circular
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green, // Set the background color
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: IconButton(
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  iconSize: 30, // Adjust icon size if needed
                  onPressed: () {
                    // Handle Home button press
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AnimalLandPage()),
                    );
                  },
                ),
              ),
              // Profile button
              Container(
                width: 60, // Set the width and height to make it circular
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue, // Set the background color for the Profile button
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: IconButton(
                  icon: const Icon(Icons.person),
                  color: Colors.white,
                  iconSize: 30, // Adjust icon size if needed
                  onPressed: () {
                    // Navigate to the Profile page with favoriteAnimals
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(favoriteAnimals: favoriteAnimals), // Send the list of favorite animals
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
