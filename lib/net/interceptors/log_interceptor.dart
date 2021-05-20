import 'package:dio/dio.dart';
import 'package:start_app/common/common.dart';

///  Dio 请求日志拦截器
class MyLogInterceptor extends InterceptorsWrapper {
  bool isDebug = AppConfig.isDebug;

  @override
  onRequest(RequestOptions options) async {
    if (isDebug) {
      print('┌─────────────────────Begin Request─────────────────────');
      printKV('uri', options.uri);
      printKV('method', options.method);
      printKV('queryParameters', options.queryParameters);
      printKV('contentType', options.contentType.toString());
      printKV('responseType', options.responseType.toString());

      StringBuffer stringBuffer = new StringBuffer();
      options.headers.forEach((key, value) {
        stringBuffer.write('\n  $key: $value');
      });
      printKV('headers', stringBuffer.toString());
      stringBuffer.clear();

      if (options.data != null) {
        printKV('body', options.data);
      }
      print('└—————————————————————End Request———————————————————————\n\n');
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (isDebug) {
      print('┌─────────────────────Begin Response—————————————————————');
      printKV('uri', response.request.uri);
      printKV('status', response.statusCode);
      printKV('responseType', response.request.responseType.toString());

      StringBuffer stringBuffer = new StringBuffer();
      response.headers.forEach((key, v) => stringBuffer.write('\n  $key: $v'));
      printKV('headers', stringBuffer.toString());
      stringBuffer.clear();

      // printLong('response: ' + response.toString());

      print('└—————————————————————End Response———————————————————————\n\n');
    }
    return response;
  }

  void printKV(String k, Object v) {}
}
