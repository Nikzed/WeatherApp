import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/data/mappers/weather_model_mapper.dart';
import 'package:weather/presentation/routing/app_router.dart';

final injector = GetIt.instance;

Future<void> setup() async {
  injector.registerSingleton<AppRouter>(AppRouter());
  injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<WeatherModelMapper>(WeatherModelMapper());
}
