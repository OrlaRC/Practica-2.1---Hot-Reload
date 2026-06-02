import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final String humidity;
  final String wind;

  const WeatherInfo({
    super.key,
    required this.humidity,
    required this.wind,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Humedad: $humidity | Viento: $wind',
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}