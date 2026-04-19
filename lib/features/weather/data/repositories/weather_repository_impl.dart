import 'package:dio/dio.dart';
import 'package:radar_clima/core/constants/api_constants.dart';
import 'package:radar_clima/core/errors/failure.dart';
import 'package:radar_clima/features/weather/data/dto/weather_dto.dart';
import 'package:radar_clima/features/weather/data/repositories/weather_repository.dart';
import 'package:radar_clima/features/weather/domain/models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio _dio;

  WeatherRepositoryImpl(this._dio);

  @override
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await _dio.get(
        'weather',
        queryParameters: {
          'q': city,
          'appid': ApiConstants.apiKey,
          'units': 'metric',
          'lang': 'pt_br', // Para descrições em português
        },
      );
      final dto = WeatherDto.fromJson(response.data);

      if (dto.weather.isEmpty) {
        throw const CityNotFoundException();
      }

      return WeatherModel(
        cityName: dto.name,
        temperature: dto.main.temp,
        description: dto.weather.first.description,
        iconUrl:
            'https://openweathermap.org/img/wn/${dto.weather.first.icon}@2x.png',
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 404) throw const CityNotFoundException();
      if (statusCode == 401) throw const ApiKeyInvalidFailure();

      throw const ServerFailure();
    }
  }
}
