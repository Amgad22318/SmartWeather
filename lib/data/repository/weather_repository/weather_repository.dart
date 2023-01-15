import 'package:weather_app_algoriza_75/data/source/network/api_result_handler.dart';
import 'package:weather_app_algoriza_75/data/source/network/my_dio.dart';

class WeatherRepository {
  Future<ApiResults> getWeatherData(String locationName) async {
    return await MyDio.getData(endPoint: "forecast.json", queryParameters: {
      "key": "0e9f044c36144953952201855231501",
      "q": locationName,
      "days": 14,
      "aqi": "no",
      "alerts": "no",
      "lang": "en",
    });
  }
}


