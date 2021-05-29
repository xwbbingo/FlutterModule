import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:start_app/demo/flutter_weather/models/weather.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        image = Image.asset('assets/weather/clear.png');
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        image = Image.asset('assets/weather/snow.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/weather/cloudy.png');
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = Image.asset('assets/weather/rainy.png');
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/weather/thunderstorm.png');
        break;
      case WeatherCondition.unknown:
        image = Image.asset('assets/weather/clear.png');
        break;
    }
    return image;
  }
}
