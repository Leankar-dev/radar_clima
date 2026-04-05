import 'package:radar_clima/features/weather/domain/models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather(String city);
}
