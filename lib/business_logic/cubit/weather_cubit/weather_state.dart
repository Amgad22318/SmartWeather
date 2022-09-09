part of 'weather_cubit.dart';

@immutable
abstract class WeatherStates {}

class WeatherInitial extends WeatherStates {}

class GetWeatherDataLoadingState extends WeatherStates {}

class GetWeatherDataSuccessState extends WeatherStates {
  final String location;

  GetWeatherDataSuccessState(this.location);
}

class GetWeatherDataEmptyState extends WeatherStates {}

class GetWeatherDataErrorState extends WeatherStates {}
