import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/constants/constants.dart';
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_cached_network_image.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_icon_button.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';

import '../../../constants/constant_methods.dart';
import '../../styles/colors.dart';

class LocationsListItem extends StatefulWidget {
  const LocationsListItem(
      {Key? key, required this.weatherResponse, required this.index})
      : super(key: key);
  final WeatherResponse weatherResponse;
  final int index;

  @override
  State<LocationsListItem> createState() => _LocationsListItemState();
}

class _LocationsListItemState extends State<LocationsListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async =>
          widget.weatherResponse.location.name !=
          WeatherCubit.get(context).currentWeatherResponse.location.name,
      onDismissed: (direction) {
        WeatherCubit.get(context)
          ..removeWeatherItem(widget.weatherResponse)
          ..getUserFavoriteWeatherLocation()
          ..getUserOtherWeatherLocation();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(18.sp),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                defaultAppWhiteColor.withOpacity(0.5),
                defaultAppColor,
                defaultAppWhiteColor.withOpacity(0.5)
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: DefaultText(
                  text: widget.weatherResponse.location.name,
                  fontSize: 12.sp,
                  overflow: TextOverflow.ellipsis,
                  color: defaultBlack,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Flexible(
                flex: 3,
                child: DefaultCachedNetworkImage(
                  imageUrl: httpSC +
                      widget.weatherResponse.currentWeather.condition.icon,
                  fit: BoxFit.fill,
                  height: 10.h,
                ),
              ),
              DefaultText(
                  text:
                      ' ${changeTempUnit(widget.weatherResponse.currentWeather.tempC, widget.weatherResponse.currentWeather.tempF)}'),
              Flexible(
                child: DefaultIconButton(
                  onPressed: () {
                    widget.weatherResponse.location.favorite
                        ? WeatherCubit.get(context)
                            .removeFavoriteWeather(widget.weatherResponse)
                        : WeatherCubit.get(context)
                            .addFavoriteWeather(widget.weatherResponse);
                    WeatherCubit.get(context)
                      ..getUserFavoriteWeatherLocation()
                      ..getUserOtherWeatherLocation();
                  },
                  icon: widget.weatherResponse.location.favorite
                      ? const Icon(
                          Icons.star,
                          color: defaultAppWhiteColor,
                        )
                      : const Icon(
                          Icons.star,
                          color: defaultDarkBlue,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
