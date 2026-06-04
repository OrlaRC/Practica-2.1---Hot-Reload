import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../utils/weather_utils.dart';

import '../widgets/weather_icon.dart';
import '../widgets/temperature_card.dart';
import '../widgets/weather_info.dart';

import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<WeatherProvider>(context);
    final weather = provider.weather;

    Widget weatherContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TemperatureCard(
          temperature: formatTemperature(
            weather.temp,
            weather.unit,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 32),

        WeatherIcon(
          icon: getWeatherIcon(weather.condition),
          color: const Color.fromARGB(255, 243, 33, 33),
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

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            provider.changeWeather();
          },
          child: const Text('Cambiar Clima'),
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
                  Expanded(
                    child: weatherContent,
                  ),
                ],
              )
            : weatherContent,
      ),
    );
  }
}