import 'dart:collection';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:start_app/demo/flutter_architecture/http/response_result_data.dart';
import 'package:start_app/demo/flutter_architecture/manager/login_manager.dart';
import 'package:start_app/demo/flutter_architecture/util/log_util.dart';

class HttpManager {
  static final String TAG = "HttpManager";

  static const _GET = "GET";
  static const _POST = "POST";

  static doGet(url) {
    return _doRequest(url, null, new Options(method: _GET));
  }

  static doPost(url, params) {
    return _doRequest(url, params, new Options(method: _POST));
  }

  static _doRequest(url, params, Options options) async {
    LogUtil.v(url, tag: TAG);
    //检查网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResponseResultData(null, false, -1);
    }
    //封装网络请求头
    Map<String, String> headers = _getHeaders();
    if (options != null) {
      options.headers = headers;
    } else {
      options = new Options(method: _GET);
      options.headers = headers;
    }
    options.contentType = Headers.jsonContentType;

    //设置请求超时时间
    options.sendTimeout = 15 * 1000;
    options.receiveTimeout = 15 * 1000;
    Dio _dio = new Dio();

    //开始请求
    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
      print('data2: $response');
      if (response.statusCode >= HttpStatus.ok &&
          response.statusCode < HttpStatus.multipleChoices) {
        return new ResponseResultData(response.data, true, response.statusCode);
      } else {
        return new ResponseResultData(
            response.data["message"], false, response.statusCode);
      }
    } on DioError catch (e) {
      LogUtil.v('request error is $e', tag: TAG);
      return new ResponseResultData(null, false, -2);
    }
  }

  static _getHeaders() {
    Map<String, String> headers = new HashMap();
    headers["Authorization"] = LoginManager.instance.getToken();
    return headers;
  }

  static download(url, savePath, progress) async {
    try {
      Dio _dio = new Dio();
      Response response =
          await _dio.download(url, savePath, onReceiveProgress: progress);
      print(response.statusCode);
    } catch (e) {
      LogUtil.v('download error is $e', tag: TAG);
    }
  }
}
