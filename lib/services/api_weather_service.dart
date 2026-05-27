import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiWeatherService {
  final apiKey = dotenv.env['API_KEY'];
  final host = dotenv.env['HOST'];
  final forecastPath = dotenv.env['FORECAST_PATH'];
  String get url => 'https://$host$forecastPath$apiKey';

  Future<void> getWeatherData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Weather data: ${response.body}');
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }
}
