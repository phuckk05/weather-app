import 'package:weather_app/models/weather.dart';

enum StateStatus { init, loading, success, fail }

class WeatherState {
  final StateStatus stateStstus;
  final WeatherForecastModel? weather;

  WeatherState({required this.stateStstus, this.weather});

  //copyWith
  WeatherState copyWith({
    StateStatus? stateStstus,
    WeatherForecastModel? weather,
  }) {
    return WeatherState(
      stateStstus: stateStstus ?? this.stateStstus,
      weather: weather ?? this.weather,
    );
  }
}
