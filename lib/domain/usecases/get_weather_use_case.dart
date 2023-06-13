import 'package:dio/dio.dart';
import 'package:weather/data/mappers/weather_model_mapper.dart';
import 'package:weather/data/services/weather_api_service.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/foundation/use_case/use_case.dart';

class GetWeatherUseCase extends UseCase<WeatherModel, GetWeatherUseCaseParams> {
  final WeatherApiService service;
  final WeatherModelMapper mapper;

  GetWeatherUseCase(this.service, this.mapper);

  @override
  Future<WeatherModel> call({required params}) async {
    try {
      final result = await service.getWeather(latitude: params.latitude, longitude: params.longitude);
      return mapper.map(result);
    } on DioException catch (e) {
      print('DioException in GetWeatherUseCase ${e.message}');
      rethrow;
    } catch (e) {
      print('Exception in GetWeatherUseCase');
      rethrow;
    }
  }
}

class GetWeatherUseCaseParams {
  double latitude;
  double longitude;

  GetWeatherUseCaseParams({required this.latitude, required this.longitude});
}
