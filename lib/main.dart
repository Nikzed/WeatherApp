import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/data/mappers/weather_model_mapper.dart';
import 'package:weather/data/services/weather_api_service.dart';
import 'package:weather/domain/models/weather_model.dart';
import 'package:weather/injector.dart';
import 'package:weather/presentation/routing/app_router.dart';
import 'package:weather/presentation/widgets/weather_background.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = injector.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter.config(),
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;

  late LocationSettings locationSettings;

  late StreamSubscription<Position> positionStream;

  int? temperature;
  String? condition;
  int? humidity;
  String? country;
  String? city;
  WeatherModel? weatherModel;

  // TODO provide location permission
  @override
  void initState() {
    super.initState();

    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 150,
    );

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      setState(() {
        _currentPosition = position;
      });
      if (position != null) getWeatherData(_currentPosition!);
    });
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  getWeatherData(Position position) async {
    WeatherApiService weatherApiService = WeatherApiService(
      Dio()
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ),
    );
    try {
      final response = await weatherApiService.getWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      weatherModel = injector<WeatherModelMapper>().map(response);
      setState(() {
        condition = weatherModel?.clouds;
        humidity = weatherModel?.humidity;
        country = weatherModel?.country;
        city = weatherModel?.city;
        temperature = weatherModel?.temperature;
      });
      print('${response.toJson()}');
    } on DioException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: WeatherBackground(weatherModel: weatherModel),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _getPlaceString(country, city),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand().copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$temperature °C',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 46,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$condition',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand().copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/humidity_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$humidity%',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand().copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  String _getPlaceString(String? country, String? city) {
    if ((country == null || country.isEmpty) && (city == null || city.isEmpty)) {
      return 'Undefined Place :(';
    } else if ((country != null && country.isNotEmpty) && (city == null || city.isEmpty)) {
      return country;
    } else if ((country == null || country.isEmpty) && (city != null && city.isNotEmpty)) {
      return city;
    }
    return '$country, $city';
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }
}
