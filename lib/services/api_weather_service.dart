import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class ApiWeatherService {
  final apiKey = dotenv.env['API_KEY'];
  final host = dotenv.env['HOST'];
  final forecastPath = dotenv.env['FORECAST_PATH'];
  String get url => 'https://$host$forecastPath$apiKey';

  Future<WeatherForecastModel> getWeatherData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
