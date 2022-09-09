import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza_75/data/repository/weather_repository/weather_repository.dart';
import 'package:weather_app_algoriza_75/data/source/network/api_result_handler.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of<WeatherCubit>(context);

  WeatherResponse weatherResponse = WeatherResponse();

  Future<void> getWeatherResponse(String location) async {
    emit(GetWeatherDataLoadingState());
    ApiResults apiResults = await WeatherRepository().getWeatherData(location);

    if (apiResults is ApiSuccess && apiResults.statusCode == 200) {
      handleResponse(apiResults.data, location);
    } else if (apiResults is ApiFailure) {
      emit(GetWeatherDataErrorState());
    }
  }

  void handleResponse(json, String location) {
    var response = WeatherResponse.fromJson(json);
    weatherResponse = response;
    emit(GetWeatherDataSuccessState(location));
  }
}
