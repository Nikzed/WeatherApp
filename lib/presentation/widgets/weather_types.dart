import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

// keys to apply smooth animation for AnimatedSwitcher
const String _sunnyKey = 'sunnyWeather';
const String _rainKey = 'rainWeather';
const String _snowKey = 'snowWeather';

class WeatherSunny extends StatelessWidget {
  const WeatherSunny({super.key = const Key(_sunnyKey)});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: MediaQuery.of(context).size,
      isLeftCornerGradient: true,
      colors: const [
        Color(0xff303f9f),
        Color(0xff1e88e5),
        Color(0xff90caf9),
      ],
      children: const [
        SunWidget(
          sunConfig: SunConfig(
              width: 300,
              blurSigma: 8,
              blurStyle: BlurStyle.solid,
              isLeftLocation: true,
              coreColor: Color(0xffffb74d),
              midColor: Color(0xffffff8d),
              outColor: Color(0xffffd180),
              animMidMill: 2000,
              animOutMill: 2000),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0xa8fafafa),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 20,
            y: 3,
            scaleBegin: 1,
            scaleEnd: 1,
            scaleCurve: Cubic(
              0.40,
              0.00,
              0.20,
              1.00,
            ),
            slideX: 24,
            slideY: 0,
            slideDurMill: 3000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
      ],
    );
  }
}

class WeatherSnow extends StatelessWidget {
  const WeatherSnow({super.key = const Key(_snowKey)});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: MediaQuery.of(context).size,
      isLeftCornerGradient: true,
      colors: const [
        Color(0xff3949ab),
        Color(0xff90caf9),
        Color(0xffd6d6d6),
      ],
      children: const [
        SnowWidget(
          snowConfig: SnowConfig(
            count: 30,
            size: 20,
            color: Color(0xb3ffffff),
            icon: IconData(57399, fontFamily: 'MaterialIcons'),
            widgetSnowflake: null,
            areaXStart: 42,
            areaXEnd: 240,
            areaYStart: 200,
            areaYEnd: 540,
            waveRangeMin: 20,
            waveRangeMax: 70,
            waveMinSec: 5,
            waveMaxSec: 20,
            waveCurve: Cubic(0.45, 0.05, 0.55, 0.95),
            fadeCurve: Cubic(0.60, 0.04, 0.98, 0.34),
            fallMinSec: 10,
            fallMaxSec: 60,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0xa8fafafa),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 20,
            y: 3,
            scaleBegin: 1,
            scaleEnd: 1.08,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0xa8fafafa),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 140,
            y: 97,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 4,
            slideDurMill: 2000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
      ],
    );
  }
}

class WeatherStorm extends StatelessWidget {
  const WeatherStorm({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: MediaQuery.of(context).size,
      isLeftCornerGradient: false,
      colors: const [
        Color(0xff263238),
        Color(0xff78909c),
      ],
      children: const [
        RainWidget(
          rainConfig: RainConfig(
            count: 40,
            lengthDrop: 13,
            widthDrop: 4,
            color: Color(0x9978909c),
            isRoundedEndsDrop: true,
            widgetRainDrop: null,
            fallRangeMinDurMill: 500,
            fallRangeMaxDurMill: 1500,
            areaXStart: 41,
            areaXEnd: 264,
            areaYStart: 208,
            areaYEnd: 620,
            slideX: 2,
            slideY: 0,
            slideDurMill: 2000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            fallCurve: Cubic(0.55, 0.09, 0.68, 0.53),
            fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04),
          ),
        ),
        ThunderWidget(
          thunderConfig: ThunderConfig(
            thunderWidth: 11,
            blurSigma: 28,
            blurStyle: BlurStyle.solid,
            color: Color(0x99ffee58),
            flashStartMill: 50,
            flashEndMill: 300,
            pauseStartMill: 50,
            pauseEndMill: 6000,
            points: [Offset(110.0, 210.0), Offset(120.0, 240.0)],
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0xad90a4ae),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 20,
            y: 3,
            scaleBegin: 1,
            scaleEnd: 1.08,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0xb1607d8b),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 140,
            y: 97,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 4,
            slideDurMill: 2000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
      ],
    );
  }
}

class WeatherRain extends StatelessWidget {
  const WeatherRain({super.key = const Key(_rainKey)});

  @override
  Widget build(BuildContext context) {
    return WrapperScene(
      sizeCanvas: MediaQuery.of(context).size,
      isLeftCornerGradient: true,
      colors: const [
        Color(0xff424242),
        Color(0xffcfd8dc),
      ],
      children: const [
        RainWidget(
          rainConfig: RainConfig(
            count: 30,
            lengthDrop: 13,
            widthDrop: 4,
            color: Color(0xff9e9e9e),
            isRoundedEndsDrop: true,
            widgetRainDrop: null,
            fallRangeMinDurMill: 500,
            fallRangeMaxDurMill: 1500,
            areaXStart: 41,
            areaXEnd: 264,
            areaYStart: 208,
            areaYEnd: 620,
            slideX: 2,
            slideY: 0,
            slideDurMill: 2000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            fallCurve: Cubic(0.55, 0.09, 0.68, 0.53),
            fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 270,
            color: Color(0xcdbdbdbd),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 119,
            y: -50,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 11,
            slideY: 13,
            slideDurMill: 4000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0x92fafafa),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 20,
            y: 3,
            scaleBegin: 1,
            scaleEnd: 1.08,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
      ],
    );
  }
}
