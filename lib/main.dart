import 'demo/flutter_architecture/architecture_main.dart'
    as flutter_architecture;
import 'demo/flutter_cart/cart_main.dart' as flutter_cart;
import 'demo/flutter_cn/cn_main.dart' as flutter_cn;
import 'demo/flutter_weather/weather_main.dart' as flutter_weather;
import 'main/wanandroid_main.dart' as flutter_wanandroid;

void main() {
  final flavor = Architecture.cn;
  switch (flavor) {
    case Architecture.wanandroid:
      flutter_wanandroid.main();
      return;
    case Architecture.weather:
      flutter_weather.main();
      return;
    case Architecture.architecture:
      flutter_architecture.main();
      return;
    case Architecture.cart:
      flutter_cart.main();
      return;
    case Architecture.cn:
      flutter_cn.main();
      return;
  }
}

enum Architecture { wanandroid, weather, architecture, cart, cn }
