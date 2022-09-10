import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_algoriza_75/constants/constant_methods.dart';
import 'package:weather_app_algoriza_75/constants/constants.dart';
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_list_response.dart';
import 'package:weather_app_algoriza_75/data/models/responses/weather_response/weather_response.dart';
import 'package:weather_app_algoriza_75/data/repository/weather_repository/weather_repository.dart';
import 'package:weather_app_algoriza_75/data/source/local/my_shared_preferences.dart';
import 'package:weather_app_algoriza_75/data/source/local/my_shared_preferences_keys.dart';
import 'package:weather_app_algoriza_75/data/source/network/api_result_handler.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of<WeatherCubit>(context);

  WeatherResponse currentWeatherResponse = WeatherResponse();

  Future<void> getCurrentWeatherResponse(String location) async {
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
    currentWeatherResponse = response;
    currentWeatherResponse.setLocationLatLong = location;
    emit(GetWeatherDataSuccessState(response));
  }

  WeatherListResponse allWeatherListResponse = WeatherListResponse();
  WeatherListResponse favoriteWeatherListResponse = WeatherListResponse();
  WeatherListResponse otherWeatherListResponse = WeatherListResponse();

  void getUserAllWeatherLocation() {
    allWeatherListResponse = weatherListResponseFromJson(
        MySharedPreferences.getString(key: MySharedKeys.userWeatherList));

    emit(GetAllWeatherDataSuccessState());
  }

  void getUserOtherWeatherLocation() {
    otherWeatherListResponse.weatherResponse.clear();

    getUserAllWeatherLocation();
    allWeatherListResponse.weatherResponse.forEach((element) {
      if (!element.location.favorite) {
        printTest(weatherResponseToJson(element));

        otherWeatherListResponse.addWeatherResponse(element);
      }
    });
    printTest(weatherListResponseToJson(otherWeatherListResponse));

    emit(GetOtherWeatherDataSuccessState());
  }

  void getUserFavoriteWeatherLocation() {
    favoriteWeatherListResponse.weatherResponse.clear();

    getUserAllWeatherLocation();
    allWeatherListResponse.weatherResponse.forEach((element) {
      if (element.location.favorite) {
        favoriteWeatherListResponse.addWeatherResponse(element);
      }
    });

    emit(GetFavoriteWeatherDataSuccessState());
  }

  Future<WeatherResponse> getTempWeatherResponse(String location) async {
    ApiResults apiResults = await WeatherRepository().getWeatherData(location);

    if (apiResults is ApiSuccess && apiResults.statusCode == 200) {
      return handleTempWeatherResponse(apiResults.data, location);
    } else {
      return WeatherResponse();
    }
  }

  WeatherResponse handleTempWeatherResponse(json, String location) {
    var response = WeatherResponse.fromJson(json);
    return response;
  }

  void changeCurrentWeather(String location) {
    getCurrentWeatherResponse(location).then((value) {
      MySharedPreferences.putString(
          key: MySharedKeys.currentWeatherLocation,
          value: weatherResponseToJson(currentWeatherResponse));
      getUserAllWeatherLocation();
      bool weatherIsExist = false;
      allWeatherListResponse.weatherResponse.forEach((element) {
        if (element.location.name == currentWeatherResponse.location.name) {
          weatherIsExist = true;
        }
      });
      if (!weatherIsExist) {
        allWeatherListResponse.weatherResponse.add(currentWeatherResponse);
      }

      MySharedPreferences.putString(
          key: MySharedKeys.userWeatherList,
          value: weatherListResponseToJson(allWeatherListResponse));
    });
  }

  void removeFavoriteWeather(WeatherResponse weatherResponse) {
    allWeatherListResponse.weatherResponse.forEach((element) {
      if (weatherResponse.location.name == element.location.name) {
        element.location.setFavorite = false;
        favoriteWeatherListResponse.weatherResponse.remove(weatherResponse);
      }
    });
    MySharedPreferences.putString(
        key: MySharedKeys.userFavoriteWeatherList,
        value: weatherListResponseToJson(favoriteWeatherListResponse));
    MySharedPreferences.putString(
        key: MySharedKeys.userWeatherList,
        value: weatherListResponseToJson(allWeatherListResponse));
  }

  void addFavoriteWeather(WeatherResponse weatherResponse) {
    allWeatherListResponse.weatherResponse.forEach((element) {
      if (weatherResponse.location.name == element.location.name) {
        element.location.setFavorite = true;
        favoriteWeatherListResponse.weatherResponse.add(element);
      }
    });
    MySharedPreferences.putString(
        key: MySharedKeys.userFavoriteWeatherList,
        value: weatherListResponseToJson(favoriteWeatherListResponse));
    MySharedPreferences.putString(
        key: MySharedKeys.userWeatherList,
        value: weatherListResponseToJson(allWeatherListResponse));

    emit(ChangeFavoriteState());
  }

  void removeWeatherItem(WeatherResponse weatherResponse) {
    allWeatherListResponse.weatherResponse.removeWhere(
        (element) => weatherResponse.location.name == element.location.name);

    MySharedPreferences.putString(
        key: MySharedKeys.userWeatherList,
        value: weatherListResponseToJson(allWeatherListResponse));

    emit(RemoveWeatherDataSuccessState());
  }

  void changeTempUnit() {
    appTempUnitIsC = !appTempUnitIsC;
    MySharedPreferences.putBoolean(
        key: MySharedKeys.tempUnit, value: appTempUnitIsC);
    emit(ChangeAppTempUnitState());
  }

  bool isLightTheme = true;
  void changeAppTheme() {
    isLightTheme = !isLightTheme;
    MySharedPreferences.putBoolean(
        key: MySharedKeys.theme, value: isLightTheme);
    emit(ChangeAppThemeState());
  }

  void getAppTheme() {
    isLightTheme =
        MySharedPreferences.getBoolean(key: MySharedKeys.theme) ?? true;
  }
}
