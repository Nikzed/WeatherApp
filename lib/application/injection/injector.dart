import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/application/config/dio_client.dart';
import 'package:weather/data/mappers/weather_model_mapper.dart';
import 'package:weather/data/services/weather_api_service.dart';
import 'package:weather/domain/usecases/get_location_permission_use_case.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';
import 'package:weather/presentation/routing/app_router.dart';
import 'package:weather/presentation/state_manager/weather_notifier.dart';

final injector = GetIt.instance;

Future<void> setup() async {
  injector.registerSingleton<AppRouter>(AppRouter());
  injector.registerLazySingleton<Dio>(() => buildDioClient());

  // Services
  injector.registerLazySingleton<WeatherApiService>(() => WeatherApiService(injector()));

  // Mappers
  injector.registerSingleton<WeatherModelMapper>(WeatherModelMapper());

  // Use Cases
  injector.registerSingleton(GetLocationPermissionUseCase());
  injector.registerSingleton(GetWeatherUseCase(injector(), injector()));

  injector.registerFactory(() => WeatherNotifier(injector(), injector()));
}
