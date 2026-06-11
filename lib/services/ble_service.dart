import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEService {
  // Iniciar búsqueda de dispositivos BLE
  Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
    );
  }

  // Obtener resultados del escaneo
  Stream<List<ScanResult>> get scanResults =>
      FlutterBluePlus.scanResults;

  // Detener escaneo
  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  // Conectar a un dispositivo
  Future<void> connect(BluetoothDevice device) async {
    await device.connect();
  }

  // Desconectar
  Future<void> disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }

  // Descubrir servicios
  Future<List<BluetoothService>> discoverServices(
      BluetoothDevice device) async {
    return await device.discoverServices();
  }
}