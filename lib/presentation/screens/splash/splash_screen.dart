import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/constants/screens.dart' as screens;
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_response.dart';

import '../../../constants/constants.dart';
import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';
import '../../styles/colors.dart';
import '../../widgets/default_rich_text.dart';
import '../../widgets/default_text_span.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late WeatherCubit weatherCubit;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    appTempUnitIsC =
        MySharedPreferences.getBoolean(key: MySharedKeys.tempUnit) ?? true;
    Timer(const Duration(milliseconds: 3000), () async {
      if (MySharedPreferences.getBoolean(key: MySharedKeys.firstTimeLocation) ==
          true) {
        WeatherResponse weatherResponse = weatherResponseFromJson(
            MySharedPreferences.getString(
                key: MySharedKeys.currentWeatherLocation));
        weatherCubit = WeatherCubit.get(context);
        weatherCubit
          ..getUserAllWeatherLocation()
          ..getUserOtherWeatherLocation()
          ..getUserFavoriteWeatherLocation();
        await weatherCubit
            .getCurrentWeatherResponse(weatherResponse.locationLatLong)
            .then((value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(screens.HOME_SCREEN, (route) => false);
        });
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            screens.PICK_LOCATION_SCREEN, (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultAppWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FadeTransition(
                  opacity: _animation,
                  child: Icon(
                    Icons.cloud,
                    size: 75.sp,
                    color: defaultAppColor,
                  )),
            ),
            Flexible(
                child: DefaultRichText(
                    text: defaultTextSpan(children: [
              defaultTextSpan(text: 'S', color: defaultAppColor2),
              defaultTextSpan(text: 'mart', color: defaultAppColor),
              defaultTextSpan(text: 'W', color: defaultAppColor2),
              defaultTextSpan(text: 'eather', color: defaultAppColor),
            ]))),
          ],
        ),
      ),
    );
  }
}
