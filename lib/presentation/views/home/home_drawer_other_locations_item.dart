import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/constants/constants.dart';
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';

import '../../../constants/constant_methods.dart';
import '../../styles/colors.dart';
import '../../widgets/default_cached_network_image.dart';

class HomeDrawerOtherLocationItem extends StatelessWidget {
  const HomeDrawerOtherLocationItem({Key? key, required this.weatherResponse})
      : super(key: key);
  final WeatherResponse weatherResponse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.sp),
      onLongPress: () {
        WeatherCubit.get(context)
            .getCurrentWeatherResponse(weatherResponse.locationLatLong);
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                children: [
                  Icon(Icons.location_pin,
                      size: 12.sp, color: defaultAppWhiteColor),
                  SizedBox(
                    height: 3.h,
                  ),
                  Flexible(
                    child: DefaultText(
                        text: weatherResponse.location.name,
                        color: defaultAppWhiteColor),
                  ),
                ],
              ),
            ),
          ),
          DefaultText(
              text:
                  ' ${changeTempUnit(weatherResponse.currentWeather.tempC, weatherResponse.currentWeather.tempF)}'),
          DefaultCachedNetworkImage(
              imageUrl: httpSC + weatherResponse.currentWeather.condition.icon,
              fit: BoxFit.contain)
        ],
      ),
    );
  }
}
