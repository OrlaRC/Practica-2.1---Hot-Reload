import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../models/weather.dart';
import '../services/ble_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather _weather = const Weather(
    city: 'Santiago de Querétaro',
    temp: 38,
    condition: 'cloudy',
    unit: 'C',
  );

  Weather get weather => _weather;

  // ==========================
  // BLE
  // ==========================

  final BLEService _bleService = BLEService();

  List<ScanResult> _devices = [];
  List<ScanResult> get devices => _devices;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  String _bleStatus = 'Sin conexión BLE';
  String get bleStatus => _bleStatus;

  Future<void> startBLEScan() async {
    try {
      _isScanning = true;
      _bleStatus = 'Buscando dispositivos BLE...';
      notifyListeners();

      await _bleService.startScan();

      _bleService.scanResults.listen((results) {
        print('Dispositivos encontrados: ${results.length}');

        _devices = results;
        notifyListeners();
      });

      _isScanning = false;
      _bleStatus = 'Escaneo completado';
      notifyListeners();
    } catch (e) {
      print('ERROR ESCANEO BLE: $e');

      _isScanning = false;
      _bleStatus = 'Error al escanear: $e';
      notifyListeners();
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      _bleStatus = 'Conectando...';
      notifyListeners();

      print('===================================');
      print('Intentando conectar...');
      print('Nombre: ${device.platformName}');
      print('ID: ${device.remoteId}');
      print('===================================');

      await _bleService.connect(device);

      print('Conectado correctamente');
      print('Iniciando discoverServices...');

      _bleStatus = 'Conectado a ${device.platformName}';
      notifyListeners();

      final services = await _bleService.discoverServices(device);

      print('========== SERVICIOS BLE ==========');

      for (final service in services) {
        print('SERVICE: ${service.uuid}');

        for (final characteristic in service.characteristics) {
          print('  CHARACTERISTIC: ${characteristic.uuid}');
        }
      }

      print('===================================');

      print('========== LECTURA BLE ==========');

      for (final service in services) {
        for (final characteristic in service.characteristics) {
          try {
            if (characteristic.properties.read) {
              final value = await characteristic.read();

              print(
                'LECTURA ${characteristic.uuid}: $value',
              );
            }
          } catch (e) {
            print(
              'No se pudo leer ${characteristic.uuid}: $e',
            );
          }
        }
      }

      print('=================================');

      device.connectionState.listen((state) {
        print('Estado conexión: $state');

        if (state == BluetoothConnectionState.disconnected) {
          print('Dispositivo desconectado');

          _bleStatus = 'Sin conexión BLE';
          notifyListeners();
        }
      });
    } catch (e) {
      print('===================================');
      print('ERROR CONEXION BLE: $e');
      print('===================================');

      _bleStatus = 'Error de conexión: $e';
      notifyListeners();
    }
  }

  // ==========================
  // WEATHER
  // ==========================

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