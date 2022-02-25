import 'dart:collection';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:start_app/net/bean/base_model.dart';
import 'package:start_app/utils/gg_log_util.dart';

import 'api/apis.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/log_interceptor.dart';

///使用默认配置
//Dio _dio = Dio();
//
//Dio get dio => _dio;

/// dio配置
class DioManager {
  static String TAG = 'DioManager';

  factory DioManager() => _getInstance();

  static DioManager get instance => _getInstance();

  static DioManager _instance;

  DioManager._internal();

  static DioManager _getInstance() {
    if (_instance == null) {
      _instance = DioManager._internal();
    }
    return _instance;
  }

  Dio dio = Dio();

  ///配置和初始化Dio
  Future init() async {
    //请求基准地址
    dio.options.baseUrl = Apis.BASE_HOST;
    //请求连接超时
    dio.options.connectTimeout = 30 * 1000;
    //请求发送超时
    dio.options.sendTimeout = 30 * 1000;
    //请求接收超时
    dio.options.receiveTimeout = 30 * 1000;
    //证书
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //证书内容
        if (cert.pem == "12222") {
          return true;
        }
        return false;
      };
    };
    //日志拦截器
    dio.interceptors.add(MyLogInterceptor());
    //异常拦截器
    dio.interceptors.add(MyErrorInterceptor());
    //cookie管理
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    print('DioUtil : http cookie path = $tempPath');
    CookieJar cj = PersistCookieJar(dir: tempPath, ignoreExpires: true);
    dio.interceptors.add(CookieManager(cj));
  }

  /// 定义一个命名参数的方法
  static String handleError(error, {String defaultErrorStr = '未知错误~'}) {
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errStr = '连接超时~';
      } else if (error.type == DioErrorType.SEND_TIMEOUT) {
        errStr = '请求超时~';
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = '响应超时~';
      } else if (error.type == DioErrorType.CANCEL) {
        errStr = '请求取消~';
      } else if (error.type == DioErrorType.RESPONSE) {
        int statusCode = error.response.statusCode;
        String msg = error.response.statusMessage;

        /// 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = '服务器异常~';
            break;
          case 404:
            errStr = '未找到资源~';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      } else if (error.type == DioErrorType.DEFAULT) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = '网络连接超时~';
        }
      } else {
        errStr = '未知错误~';
      }
    }
    return errStr ?? defaultErrorStr;
  }

  get(String url, {bool isCache: true}) async {
    RequestBuilder requestBuilder = RequestBuilder()
      ..method(HttpMethod.GET)
      ..isCache(isCache)
      ..url(url);

    return await builder(requestBuilder);
  }

  post(String url, dynamic data) async {
    RequestBuilder requestBuilder = RequestBuilder()
      ..isCache(false)
      ..method(HttpMethod.POST)
      ..url(url)
      ..data(data);

    return await builder(requestBuilder);
  }

  delete(String url, {bool isCache: true}) async {
    RequestBuilder requestBuilder = RequestBuilder()
      ..method(HttpMethod.DELETE)
      ..isCache(isCache)
      ..url(url);

    return await builder(requestBuilder);
  }

  put(String url, {bool isCache: true}) async {
    RequestBuilder requestBuilder = RequestBuilder()
      ..method(HttpMethod.PUT)
      ..isCache(isCache)
      ..url(url);

    return await builder(requestBuilder);
  }

  patch(String url, dynamic data) async {
    RequestBuilder requestBuilder = RequestBuilder()
      ..isCache(false)
      ..method(HttpMethod.PATCH)
      ..url(url)
      ..data(data);

    return await builder(requestBuilder);
  }

  download(url, savePath, progress) async {
    try {
      Response response =
          await dio.download(url, savePath, onReceiveProgress: progress);
      print(response.statusCode);
    } catch (e) {
      GgLogUtil.v('download error is $e', tag: TAG);
    }
  }

  builder(RequestBuilder builder) async {
//    if (builder.getCache()) {
//      int time = SpUtil.instance.getInt(SP_KEY_CACHE_TIME, defValue: 4);
//      if (time > 0) {
//        CacheProvider provider = CacheProvider();
//        var result = await provider.query(builder.getUrl());
//        if (result != null) {
//          var data = jsonDecode(result.data);
//          DateTime dateTime = DateTime.parse(result.dateTime);
//          int subTime = DateTime.now().millisecondsSinceEpoch -
//              dateTime.millisecondsSinceEpoch;
//          if (subTime <= time * 60 * 60 * 1000) {
//            LogUtil.v('load data from cache, url is ' + builder.getUrl(),
//                tag: TAG);
//            return ResponseResultData(data, true, 200);
//          }
//        }
//      }
//    }
    return await _doRequest(builder);
  }

  _doRequest(RequestBuilder builder) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    //无网络
    if (connectivityResult == ConnectivityResult.none) {
      return BaseModel(null, false, -1);
    }

    Options addOptions = Options(
      method: _getMethod(builder.getMethod()),
      headers: _getHeaders(builder.getHeader()),
      responseType: builder.getResponseType(),
    );

    String url = builder.getUrl();
    // LogUtil.v(url /*+ '-->' + builder.getData().toString()*/);

//    Dio _dio = Dio(options);
    //开始请求
    Response response;
    try {
      response = await dio.request(
        url,
        data: builder.getData(),
        options: addOptions,
        queryParameters: builder.getQueryParameters(),
      );

      if (response.statusCode >= HttpStatus.ok &&
          response.statusCode < HttpStatus.multipleChoices) {
//        if (builder._isCache) {
//          CacheProvider provider = CacheProvider();
//          provider.insert(
//              url, jsonEncode(response.data), DateTime.now().toIso8601String());
//        }
        //  LogUtil.v(
        //      'load data from network and success, url is ' + builder.getUrl(),
        //      tag: TAG);
        // LogUtil.v(response.data);
        return BaseModel(
          response.data,
          true,
          response.statusCode,
        );
      } else {
        // LogUtil.v(
        //     'load data from network and error code, url is ' + builder.getUrl(),
        //     tag: TAG);
        return BaseModel(response.data["message"], false, response.statusCode);
      }
    } on DioError catch (e) {
//      ToastUtil.showMessgae(e.toString());
//       LogUtil.v('load data from network and exception, e is ' + e.toString(),
//           tag: TAG);
      return BaseModel(null, false, -2);
    }
  }

  String _getMethod(HttpMethod method) {
    if (method == HttpMethod.DELETE) {
      return 'DELETE';
    } else if (method == HttpMethod.PATCH) {
      return 'PATCH';
    } else if (method == HttpMethod.POST) {
      return 'POST';
    } else if (method == HttpMethod.PUT) {
      return 'PUT';
    }
    return 'GET';
  }

  Map<String, dynamic> _getHeaders(Map<String, dynamic> header) {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    headers["Authorization"] = 'token'; //LoginManager.instance.getToken();
    return headers;
  }
}

class RequestBuilder {
  HttpMethod _method;
  Map<String, dynamic> _headers;
  ResponseType _contentType = ResponseType.json;
  dynamic _data;
  Map<String, dynamic> _queryParameters;
  String _url;
  bool _isCache = true;

  RequestBuilder method(HttpMethod method) {
    this._method = method;
    return this;
  }

  RequestBuilder header(Map<String, dynamic> headers) {
    this._headers = headers;
    return this;
  }

  RequestBuilder contentType(ResponseType contentType) {
    this._contentType = contentType;
    return this;
  }

  RequestBuilder queryParameters(Map<String, dynamic> queryParameters) {
    this._queryParameters = queryParameters;
    return this;
  }

  RequestBuilder data(dynamic data) {
    this._data = data;
    return this;
  }

  RequestBuilder url(String url) {
    this._url = url;
    return this;
  }

  RequestBuilder isCache(bool isCache) {
    this._isCache = isCache;
    return this;
  }

  HttpMethod getMethod() {
    return _method;
  }

  Map<String, dynamic> getHeader() {
    return _headers;
  }

  ResponseType getResponseType() {
    return _contentType;
  }

  Map<String, dynamic> getQueryParameters() {
    return _queryParameters;
  }

  dynamic getData() {
    return _data;
  }

  String getUrl() {
    return _url;
  }

  bool getCache() {
    return _isCache;
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}
