import 'package:logger/logger.dart';
import 'package:start_app/common/common.dart';

class GgLogUtil {
  static const String _defTag = 'xwb';

  static int _maxLen = 128;
  static String _tagValue = _defTag;
  static Logger _logger;
  static Logger _loggerNoStack;

  static void init({String tag = _defTag, int maxLen = 128}) {
    _tagValue = tag;
    _maxLen = maxLen;
    _logger = Logger(
        printer: PrettyPrinter(
      colors: false,
    ));
    _loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));
  }

  static void d(Object object, {String tag}) {
    if (AppConfig.isDebug) {
      if (tag == null) {
        tag = _tagValue;
      }
      _logger.d('D=$tag=>> ' + object.toString());
    }
  }

  static void e(Object object, {String tag}) {
    if (tag == null) {
      tag = _tagValue;
    }
    _logger.e('E=$tag=>> ' + object.toString());
  }

  static void v(Object object, {String tag}) {
    if (AppConfig.isDebug) {
      if (tag == null) {
        tag = _tagValue;
      }
      _logger.v('V=$tag=>> ' + object.toString());
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      print('$tag$stag $da');
      return;
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — START — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print('$tag$stag| ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$tag$stag| $da');
        da = '';
      }
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — END — — — — — — — — — — — — — — — —');
  }
}
