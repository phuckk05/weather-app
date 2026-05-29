import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather/weather_event.dart';
import 'package:weather_app/blocs/weather/weather_state.dart';

import '../../models/weather.dart';
import '../../services/api_weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  Stream<WeatherForecastModel?> get weatherStream =>
      stream.map((state) => state.weather).distinct();

  WeatherBloc()
    : super(WeatherState(stateStstus: StateStatus.init, weather: null)) {
    // Xử lý sự kiện LoadingData
    on<LoadingData>((event, emit) async {
      emit(state.copyWith(stateStstus: StateStatus.loading));
      try {
        // Giả sử bạn có một phương thức để lấy dữ liệu thời tiết
        await for (var weatherData in ApiWeatherService().getWeatherData(
          event.city,
        )) {
          emit(
            state.copyWith(
              stateStstus: StateStatus.success,
              weather: weatherData,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(stateStstus: StateStatus.fail, weather: null));
      }
    });
  }
}
