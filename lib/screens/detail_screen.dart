import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String city;

  const DetailScreen({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    final forecast = [
      {'day': 'Lun', 'temp': '24°C'},
      {'day': 'Mar', 'temp': '26°C'},
      {'day': 'Mié', 'temp': '22°C'},
      {'day': 'Jue', 'temp': '25°C'},
      {'day': 'Vie', 'temp': '28°C'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$city - 5 Días'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.cloud),
              title: Text(forecast[index]['day']!),
              trailing: Text(
                forecast[index]['temp']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}