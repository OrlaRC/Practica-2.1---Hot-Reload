import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather _weather = const Weather(
    city: 'Santiago de Querétaro',
    temp: 38,
    condition: 'cloudy',
    unit: 'C',
  );

  Weather get weather => _weather;

  void updateCity(String city) {
    if (city.trim().isEmpty) return;

    _weather = _weather.copyWith(city: city);
    notifyListeners();
  }

  void updateTemperature(double temp) {
    if (temp < -60 || temp > 60) return;

    _weather = _weather.copyWith(temp: temp);
    notifyListeners();
  }

  void changeWeather() {
    if (_weather.city == 'Santiago de Querétaro') {
      _weather = const Weather(
        city: 'Ciudad de México',
        temp: 25,
        condition: 'sunny',
        unit: 'C',
      );
    } else {
      _weather = const Weather(
        city: 'Santiago de Querétaro',
        temp: 38,
        condition: 'cloudy',
        unit: 'C',
      );
    }

    notifyListeners();
  }
}