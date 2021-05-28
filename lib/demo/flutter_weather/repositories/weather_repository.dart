import 'dart:async';

import 'package:meta/meta.dart';
import 'package:start_app/demo/flutter_weather/models/weather.dart';
import 'package:start_app/demo/flutter_weather/repositories/weather_api_client.dart';

/// 通过全局的api 获取相应的信息
class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }
}
