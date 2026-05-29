import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather.dart';

class HourlyForeCast extends StatelessWidget {
  final List<WeatherItem> items;

  const HourlyForeCast({super.key, required this.items});

  DateTime _parseDt(String dtTxt) {
    return DateTime.parse(dtTxt.replaceFirst(' ', 'T'));
  }

  IconData _iconForMain(String main) {
    switch (main.toLowerCase()) {
      case 'rain':
        return Icons.cloud_rounded;
      case 'clouds':
        return Icons.cloud_rounded;
      case 'clear':
        return Icons.sunny;
      default:
        return Icons.cloud_rounded;
    }
  }

  double _toCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HOURLY FORECAST
              const Text(
                'HOURLY FORECAST',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Text(
                          'No hourly data',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final time = DateFormat(
                            'HH:mm',
                          ).format(_parseDt(item.dtTxt));
                          final icon = _iconForMain(item.weather.first.main);
                          return Container(
                            width: 70,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Icon(icon, color: Colors.white, size: 20),
                                const SizedBox(height: 5),
                                Text(
                                  '${_toCelsius(item.main.temp).round()}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemCount: items.length,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
