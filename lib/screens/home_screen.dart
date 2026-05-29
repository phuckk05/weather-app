import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/theme.dart';

import '../blocs/weather/weather_bloc.dart';
import '../blocs/weather/weather_event.dart';
import '../blocs/weather/weather_state.dart';
import '../cubits/theme_cubit.dart';
import '../main.dart';
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
    context.read<WeatherBloc>().add(LoadingData());
    super.initState();
  }

  void _updateTheme(WeatherTheme theme) {
    context.read<ThemeCubit>().updateTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.themeData == ThemeApp.rainTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _updateTheme(WeatherTheme.rain),
          ),
        ],
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          debugPrintStack(label: 'WeatherState changed: ${state.stateStstus}');
        },
        child: Stack(
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

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InformationNowCus(
                      city: 'Ha Noi',
                      temp: '28°C',
                      weatherIcon: 'cloud',
                    ),
                    //thời tiết theo giờ + cuộn ngang
                    const SizedBox(height: 20),
                    const HourlyForeCast(),
                    SizedBox(height: 20),
                    //thởi tiết 7 ngày
                    const DayForeCast(),
                    //air quality
                    const SizedBox(height: 20),
                    const PropertiesCard(
                      title: 'AIR QUALITY',
                      value: 'Good (AQI: 50)',
                    ),
                    //UV index
                    const SizedBox(height: 20),
                    const PropertiesCard(
                      title: 'UV INDEX',
                      value: '5 (Moderate)',
                    ),
                    //humidity
                    const SizedBox(height: 20),
                    const PropertiesCard(title: 'HUMIDITY', value: '60%'),
                    const SizedBox(height: 20),
                    const PropertiesCard(title: 'VISIBILITY', value: '10 km'),
                    //dân số
                    const SizedBox(height: 20),
                    const PropertiesCard(
                      title: 'POPULATION',
                      value: '8.5 million',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
