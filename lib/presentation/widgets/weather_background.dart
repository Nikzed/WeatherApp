import 'package:flutter/material.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/presentation/widgets/weather_types.dart';

class WeatherBackground extends StatefulWidget {
  final WeatherModel? weatherModel;

  const WeatherBackground({super.key, this.weatherModel});

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground> {
  @override
  Widget build(BuildContext context) {
    return widget.weatherModel == null
        ? const WeatherSunny(
            key: Key('initial'),
          )
        : _getWeatherWidget(widget.weatherModel?.clouds, true, widget.weatherModel?.temperature);
  }

  Widget _getWeatherWidget(String? clouds, bool isDaytime, int? temperature) {
    switch (clouds) {
      case 'Thunderstorm':
        return const WeatherStorm();
      case 'Rain':
        return const WeatherRain();
      case 'Snow':
        return const WeatherSnow();
    }
    if (temperature != null && temperature < 0) {
      return const WeatherSnow();
    }
    return const WeatherSunny();
  }
}
