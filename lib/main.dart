import 'demo/flutter_weather/weather_main.dart' as flutter_weather;
import 'main/wanandroid_main.dart' as flutter_wanandroid;

void main() {
  final flavor = Architecture.weather;
  switch (flavor) {
    case Architecture.wanandroid:
      flutter_wanandroid.main();
      return;
    case Architecture.weather:
      flutter_weather.main();
      return;
  }
}

enum Architecture { wanandroid, weather }
