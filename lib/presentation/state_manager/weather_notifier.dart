import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/models/location_permission_model.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/domain/usecases/get_location_permission_use_case.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';

class WeatherNotifier with ChangeNotifier {
  final GetLocationPermissionUseCase _getLocationPermissionUseCase;
  final GetWeatherUseCase _getWeatherUseCase;

  bool permissionGranted = false;

  String? errorText;

  bool isLoading = true;

  Position? _currentPosition;

  LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 150,
  );

  // ignore: unused_field
  StreamSubscription<Position>? _positionStream;

  WeatherModel? weather;

  WeatherNotifier(this._getLocationPermissionUseCase, this._getWeatherUseCase);

  Future<void> definePermission() async {
    LocationPermissionModel result = await _getLocationPermissionUseCase.call();
    permissionGranted = result.permission;
    errorText = result.errorText;
    isLoading = false;
    if (result.permission) _initPositionStream();
    notifyListeners();
  }

  Future<void> _initPositionStream() async {
    _positionStream = await Geolocator.getPositionStream(locationSettings: _locationSettings).listen(
      (Position? position) async {
        _currentPosition = position;
        if (_currentPosition != null)
          weather = await _getWeatherUseCase.call(
            params: GetWeatherUseCaseParams(
              latitude: _currentPosition!.latitude,
              longitude: _currentPosition!.longitude,
            ),
          );
        notifyListeners();
      },
    );
  }
}
