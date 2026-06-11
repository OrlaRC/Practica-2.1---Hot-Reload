import 'package:flutter/material.dart';

String formatTemperature(
  double temp,
  String unit,
) {
  return '${temp.toStringAsFixed(0)}°$unit';
}

IconData getWeatherIcon(String condition) {
  switch (condition.toLowerCase()) {
    case 'sunny':
      return Icons.wb_sunny;

    case 'rainy':
      return Icons.water_drop;

    case 'cloudy':
    default:
      return Icons.cloud;
  }
}

Color getWeatherColor(String condition) {
  switch (condition.toLowerCase()) {
    case 'sunny':
      return Colors.orange;

    case 'rainy':
      return Colors.blue;

    case 'cloudy':
    default:
      return Colors.blueGrey;
  }
}