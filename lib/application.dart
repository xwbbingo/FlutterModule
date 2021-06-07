import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

var _logger = Logger();

Logger get logger => _logger;

class Application {
  static FluroRouter router;
  static Store store;
}
