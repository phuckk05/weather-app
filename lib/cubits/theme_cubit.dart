import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/main.dart';

class ThemeCubit extends Cubit<WeatherTheme> {
  ThemeCubit() : super(WeatherTheme.clear);

  void updateTheme(WeatherTheme theme) {
    emit(theme);
  }
}
