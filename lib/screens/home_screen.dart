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
    final provider = Provider.of<WeatherProvider>(context);
    final weather = provider.weather;

    final weatherColor =
        getWeatherColor(weather.condition);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather BLE'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: weatherColor,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    WeatherIcon(
                      icon: getWeatherIcon(
                        weather.condition,
                      ),
                      color: Colors.white,
                    ),

                    const SizedBox(height: 12),

                    TemperatureCard(
                      temperature: formatTemperature(
                        weather.temp,
                        weather.unit,
                      ),
                    ),

                    Text(
                      weather.city,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const WeatherInfo(
                      humidity: '65%',
                      wind: '12 km/h',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.search),
                    label: const Text(
                      'Buscar Ciudad',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const SearchScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: const Text(
                      'Cambiar Clima',
                    ),
                    onPressed: () {
                      provider.changeWeather();
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.bluetooth,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Bluetooth LE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      provider.bleStatus,
                      style: TextStyle(
                        fontSize: 16,
                        color: provider.bleStatus
                                .contains(
                                    'Conectado')
                            ? Colors.green
                            : Colors.red,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.bluetooth_searching,
                      ),
                      label: Text(
                        provider.isScanning
                            ? 'Buscando...'
                            : 'Buscar dispositivos',
                      ),
                      onPressed:
                          provider.isScanning
                              ? null
                              : () {
                                  provider
                                      .startBLEScan();
                                },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  provider.devices.length,
              itemBuilder: (context, index) {
                final result =
                    provider.devices[index];

                final device =
                    result.device;

                return Card(
                  margin:
                      const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.devices,
                    ),
                    title: Text(
                      device.platformName
                              .isNotEmpty
                          ? device.platformName
                          : 'BLE Device',
                    ),
                    subtitle: Text(
                      device.remoteId
                          .toString(),
                    ),
                    trailing:
                        ElevatedButton(
                      onPressed: () {
                        provider
                            .connectToDevice(
                                device);
                      },
                      child: const Text(
                        'Conectar',
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}