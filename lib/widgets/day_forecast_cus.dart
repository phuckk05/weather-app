import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayForecastItem {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String main;

  DayForecastItem({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.main,
  });
}

class DayForeCast extends StatelessWidget {
  final List<DayForecastItem> items;

  const DayForeCast({super.key, required this.items});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '7-DAY FORECAST',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'No daily data',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final label = DateFormat('EEE').format(item.date);
                        final icon = _iconForMain(item.main);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Icon(icon, color: Colors.white, size: 20),
                            Text(
                              '${_toCelsius(item.minTemp).round()}° / ${_toCelsius(item.maxTemp).round()}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: items.length,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
