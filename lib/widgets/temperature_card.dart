import 'package:flutter/material.dart';

class TemperatureCard extends StatelessWidget {
  final String temperature;

  const TemperatureCard({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      temperature,
      style: const TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}