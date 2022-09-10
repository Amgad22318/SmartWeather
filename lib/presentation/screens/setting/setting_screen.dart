import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/constants/constants.dart';
import 'package:weather_app_algoriza_75/presentation/styles/colors.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_material_button.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  late WeatherCubit weatherCubit;

  @override
  Widget build(BuildContext context) {
    weatherCubit = WeatherCubit.get(context);
    return SafeArea(
      child: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const DefaultText(
                text: 'Setting',
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
              child: Column(
                children: [
                  DefaultMaterialButton(
                    onPressed: () {
                      weatherCubit.changeTempUnit();
                    },
                    text: appTempUnitIsC ? 'Celsius C°' : 'Fahrenheit F°',
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      DefaultText(text: 'Darkmode', fontSize: 18.sp),
                      const Spacer(),
                      Switch(
                          activeColor: defaultAppColor2,
                          value: weatherCubit.isLightTheme,
                          onChanged: (value) {
                            weatherCubit.changeAppTheme();
                          })
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
