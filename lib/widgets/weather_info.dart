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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Icon(Icons.water_drop),
            const SizedBox(width: 6),
            Text(humidity),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.air),
            const SizedBox(width: 6),
            Text(wind),
          ],
        ),
      ],
    );
  }
}