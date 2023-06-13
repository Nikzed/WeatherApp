import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/mappers/weather_model_mapper.dart';
import 'package:weather/data/models/weather_response.dart';

void main() {
    late WeatherResponse weatherResponse;
    WeatherModelMapper weatherModelMapper = WeatherModelMapper();

    test('WeatherModelMapper', () {
      weatherResponse = WeatherResponse(
        200,
        WeatherTemperatureResponse(20.0, 50),
        [WeatherCloudsResponse('Rain', 'Heavy rain')],
        WeatherCountryResponse('US'),
        'Paradise',
        {},
      );

      final result = weatherModelMapper.map(weatherResponse);

      expect(result.temperature, equals(20.0));
      expect(result.humidity, equals(50));
      expect(result.clouds, equals('Rain'));
      expect(result.cloudsDescription, equals('Heavy rain'));
      expect(result.windSpeed, equals(.0));
      expect(result.country, equals('US'));
      expect(result.city, equals('Paradise'));
    });

    test('WeatherModelMapper', () {
      weatherResponse = WeatherResponse(
        200,
        WeatherTemperatureResponse(0, 0),
        [WeatherCloudsResponse('Snow', 'Regular snow')],
        WeatherCountryResponse('France'),
        'Paris',
        {'speed' : 10.0},
      );

      final result = weatherModelMapper.map(weatherResponse);

      expect(result.temperature, equals(0));
      expect(result.humidity, equals(0));
      expect(result.clouds, equals('Snow'));
      expect(result.cloudsDescription, equals('Regular snow'));
      expect(result.windSpeed, equals(10.0));
      expect(result.country, equals('France'));
      expect(result.city, equals('Paris'));
      expect(result.windSpeed, 10.0);
    });
}