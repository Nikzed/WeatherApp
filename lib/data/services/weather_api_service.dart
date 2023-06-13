import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather/data/constants.dart';
import 'package:weather/data/models/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/')
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
    );

    return _WeatherApiService(dio, baseUrl: baseUrl);
  }

  @GET('/weather')
  Future<WeatherResponse> getWeather({
    @Query('APPID') String apiKey = apiKey,
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('units') String units = 'metric',
  });
}
