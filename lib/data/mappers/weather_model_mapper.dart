import 'package:weather/data/models/weather_response.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/foundation/utils/mapper.dart';

class WeatherModelMapper implements Mapper<WeatherResponse, WeatherModel> {
  @override
  WeatherModel map(WeatherResponse value) {
    return WeatherModel(
      temperature: value.temperature!.temperature!.round(),
      humidity: value.temperature!.humidity!,
      clouds: value.clouds.first.clouds!,
      cloudsDescription: value.clouds.first.description!,
      windSpeed: value.wind['speed'] ?? .0,
      country: value.country.country,
      city: value.city,
    );
  }

  @override
  WeatherResponse reverseMap(WeatherModel value) {
    throw UnimplementedError();
  }
}