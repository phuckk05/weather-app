abstract class WeatherEvent {}

class LoadingData extends WeatherEvent {
  final String city;
  LoadingData({this.city = 'Hanoi'});
}
