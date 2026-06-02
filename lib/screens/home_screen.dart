import 'package:flutter/material.dart';

import '../widgets/weather_icon.dart';
import '../widgets/temperature_card.dart';
import '../widgets/weather_info.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget weatherContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TemperatureCard(
          temperature: '38°C',
        ),
        const SizedBox(height: 16),
        const Text(
          'Santiago de Querétaro',
          style: TextStyle(
            fontSize: 24,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32),
        const WeatherIcon(
          icon: Icons.cloud,
          color: Color.fromARGB(255, 243, 33, 33),
        ),
        const SizedBox(height: 24),
        const WeatherInfo(
          humidity: '65%',
          wind: '12 km/h',
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SearchScreen(),
              ),
            );
          },
          child: const Text('Buscar Ciudades'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Actual'),
        centerTitle: true,
      ),
      body: Center(
        child: width > 600
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: weatherContent),
                ],
              )
            : weatherContent,
      ),
    );
  }
}