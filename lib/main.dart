import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/presentation/router/app_router.dart';

import 'business_logic/cubit/observer.dart';
import 'data/source/local/my_shared_preferences.dart';
import 'data/source/network/my_dio.dart';
import 'presentation/styles/themes.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.init();
  await MyDio.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  late WeatherCubit weatherCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              weatherCubit = WeatherCubit.get(context);
              weatherCubit.getAppTheme();
              return MaterialApp(
                theme: weatherCubit.isLightTheme
                    ? Themes.lightTheme
                    : Themes.darkTheme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: appRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
