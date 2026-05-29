import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/theme.dart';

import '../blocs/weather/weather_bloc.dart';
import '../blocs/weather/weather_event.dart';
import '../blocs/weather/weather_state.dart';
import '../constants/ultis.dart';
import '../cubits/theme_cubit.dart';
import '../main.dart';
import '../models/weather.dart';
import '../services/location_service.dart';
import '../widgets/day_forecast_cus.dart';
import '../widgets/hourly_forecast_cus.dart';
import '../widgets/information_now_cus.dart';
import '../widgets/properties_card_cus.dart';

class HomeScreen extends StatefulWidget {
  final ThemeData themeData;
  const HomeScreen({super.key, required this.themeData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    //lấy tỉnh thành trên thiết bị
    LocationService()
        .getCurrentCity()
        .then((city) {
          final cityName = city != null
              ? '${Ultis().removeVietnameseDiacritics(city)} City'
              : 'Hanoi';
          print('Current city: $cityName');
          context.read<WeatherBloc>().add(LoadingData(city: cityName));
        })
        .catchError((error) {
          debugPrint('Failed to get location: $error');
        });
    // Nếu không lấy được vị trí, vẫn cố gắng tải dữ liệu thời tiết với thành phố mặc định
    // context.read<WeatherBloc>().add(LoadingData(city: 'Hanoi'));
    // });

    super.initState();
  }

  void _updateTheme(WeatherTheme theme) {
    context.read<ThemeCubit>().updateTheme(theme);
  }

  double _toCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  DateTime _parseDt(String dtTxt) {
    return DateTime.parse(dtTxt.replaceFirst(' ', 'T'));
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<WeatherItem> _buildHourlyItems(WeatherForecastModel weather) {
    final now = DateTime.now();
    final todayItems = weather.list
        .where((item) => _isSameDate(_parseDt(item.dtTxt), now))
        .toList();
    if (todayItems.isNotEmpty) {
      return todayItems;
    }

    final fallbackDate = _parseDt(weather.list.first.dtTxt);
    return weather.list
        .where((item) => _isSameDate(_parseDt(item.dtTxt), fallbackDate))
        .toList();
  }

  List<DayForecastItem> _buildDailyItems(WeatherForecastModel weather) {
    final Map<String, List<WeatherItem>> grouped = {};
    for (final item in weather.list) {
      final date = _parseDt(item.dtTxt);
      final key = '${date.year}-${date.month}-${date.day}';
      grouped.putIfAbsent(key, () => []).add(item);
    }

    final days = grouped.values.map((items) {
      final date = _parseDt(items.first.dtTxt);
      double minTemp = items.first.main.temp;
      double maxTemp = items.first.main.temp;
      for (final item in items) {
        if (item.main.temp < minTemp) minTemp = item.main.temp;
        if (item.main.temp > maxTemp) maxTemp = item.main.temp;
      }
      return DayForecastItem(
        date: date,
        minTemp: minTemp,
        maxTemp: maxTemp,
        main: items.first.weather.first.main,
      );
    }).toList()..sort((a, b) => a.date.compareTo(b.date));

    if (days.length > 7) {
      return days.sublist(0, 7);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.themeData == ThemeApp.rainTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Weather App'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       onPressed: () => _updateTheme(WeatherTheme.rain),
      //     ),
      //   ],
      // ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.stateStstus == StateStatus.success) {
            // Cập nhật theme dựa trên dữ liệu thời tiết
            switch (state.weather?.list.first.weather.first.main
                .toLowerCase()) {
              case 'rain':
                _updateTheme(WeatherTheme.rain);
                break;
              case 'clear':
                _updateTheme(WeatherTheme.clear);
                break;
              case 'clouds':
                _updateTheme(WeatherTheme.cloudy);
                break;
              default:
                _updateTheme(WeatherTheme.clear);
            }
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            final weather = state.weather;
            final mainValue = weather?.list.first.weather.first.main
                .toLowerCase();
            final weatherIcon = (mainValue == 'rain' || mainValue == 'clouds')
                ? 'cloud'
                : 'sunny';

            Widget content;
            if (state.stateStstus == StateStatus.loading) {
              content = const Center(child: CircularProgressIndicator());
            } else if (state.stateStstus == StateStatus.fail) {
              content = const Center(
                child: Text(
                  'Failed to load weather data',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (weather == null || weather.list.isEmpty) {
              content = const Center(
                child: Text(
                  'No weather data available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final firstItem = weather.list.first;
              // final modelDump = _buildModelDump(weather);
              final hourlyItems = _buildHourlyItems(weather);
              final dailyItems = _buildDailyItems(weather);
              content = SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InformationNowCus(
                        city: weather.city.name,
                        temp: '${_toCelsius(firstItem.main.temp).round()}°C',
                        weatherIcon: weatherIcon,
                      ),
                      //thời tiết theo giờ + cuộn ngang
                      const SizedBox(height: 20),
                      HourlyForeCast(items: hourlyItems),
                      SizedBox(height: 20),
                      //thởi tiết 7 ngày
                      DayForeCast(items: dailyItems),
                      //air quality
                      const SizedBox(height: 20),
                      PropertiesCard(
                        title: 'HUMIDITY',
                        value: '${firstItem.main.humidity}%',
                      ),
                      const SizedBox(height: 20),
                      PropertiesCard(
                        title: 'VISIBILITY',
                        value: '${firstItem.visibility} m',
                      ),
                      const SizedBox(height: 20),
                      PropertiesCard(
                        title: 'WIND',
                        value:
                            '${firstItem.wind.speed} m/s, ${firstItem.wind.deg}°',
                      ),
                      const SizedBox(height: 20),
                      PropertiesCard(title: 'POP', value: '${firstItem.pop}'),
                      const SizedBox(height: 20),
                      // PropertiesCard(title: 'MODEL DATA', value: modelDump),
                    ],
                  ),
                ),
              );
            }

            return Stack(
              children: [
                if (isDarkMode) ...[
                  Image.asset(
                    'assets/images/rain.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ] else ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ],
                //làm mờ ảnh nền
                Container(color: Colors.black.withOpacity(0.5)),
                content,
              ],
            );
          },
        ),
      ),
    );
  }
}
