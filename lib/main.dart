import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/application/injection/injector.dart';
import 'package:weather/presentation/routing/app_router.dart';
import 'package:weather/presentation/state_manager/weather_notifier.dart';
import 'package:weather/presentation/widgets/weather_background.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => injector<WeatherNotifier>()..definePermission(),
      child: Scaffold(
        body: Consumer<WeatherNotifier>(builder: (context, weatherNotifier, child) {
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: WeatherBackground(weatherModel: weatherNotifier.weather),
              ),
              weatherNotifier.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : weatherNotifier.permissionGranted
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (weatherNotifier.weather == null)
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                else ...[
                                  Text(
                                    _getPlaceString(weatherNotifier.weather?.country, weatherNotifier.weather?.city),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand().copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${weatherNotifier.weather?.temperature} °C',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 46,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${weatherNotifier.weather?.clouds}',
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
                                        '${weatherNotifier.weather?.humidity}%',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.quicksand().copyWith(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                weatherNotifier.errorText ?? 'Undefined ERROR, please try to reload an app',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand().copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  await weatherNotifier.definePermission();
                                },
                                child: Text('Grant permission'),
                              ),
                            ],
                          ),
                        ),
            ],
          );
        }),
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
}
