import 'package:flutter/material.dart';

import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> cities = [
    'Santiago de Querétaro',
    'Ciudad de México',
    'Monterrey',
    'Guadalajara',
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredCities = cities
        .where(
          (city) =>
              city.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Ciudad'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar ciudad...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final city = filteredCities[index];

                return ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(city),
                  subtitle: const Text('24°C'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(city: city),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}