import 'package:flutter/material.dart';

import '../services/api_weather_service.dart';
import '../widgets/day_forecast_cus.dart';
import '../widgets/hourly_forecast_cus.dart';
import '../widgets/information_now_cus.dart';
import '../widgets/properties_card_cus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiWeatherService _weatherService = ApiWeatherService();

  @override
  void initState() {
    _weatherService.getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/rain.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
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
    );
  }
}
