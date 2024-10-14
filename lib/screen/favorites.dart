import 'package:flutter/material.dart';
import '../widgets/animal_card.dart';
import 'showdata.dart'; // อย่าลืม import หน้า ShowData

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteAnimals;

  const FavoritesPage({Key? key, required this.favoriteAnimals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Animals'),
        backgroundColor: Colors.blue,
      ),
      body: favoriteAnimals.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteAnimals.length,
              itemBuilder: (context, index) {
                return AnimalCard(
                  name: favoriteAnimals[index]['name'] ?? 'Unknown',
                  imagePath: favoriteAnimals[index]['imagePath'] ?? 'assets/placeholder.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowData( // เปลี่ยน AnimalCard เป็น ShowData
                          name: favoriteAnimals[index]['name'] ?? 'Unknown',
                          description: favoriteAnimals[index]['description'] ?? 'No description available',
                          location: favoriteAnimals[index]['location'] ?? 'Unknown location',
                          behavior: favoriteAnimals[index]['behavior'] ?? 'No behavior information available',
                          imagePath: favoriteAnimals[index]['imagePath'] ?? 'assets/placeholder.jpg',
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text('No favorite animals yet.'),
            ),
    );
  }
}
