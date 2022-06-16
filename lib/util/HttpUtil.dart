import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mall/config/GlobalConfig.dart';
import 'ResultCode.dart';

class HttpUtil {
  // http://mall.miaoxing.fun
  // http://192.168.1.63:8383
  static String httpUrl = "http://mall.miaoxing.fun";
  static String token = '';
  static Dio dio = new Dio();

  static get(String url, params, Function successCallBack,
      Function errorCallBack) async {
    return requestHttp(url, 'get', params, successCallBack, errorCallBack);
  }

  static post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    return requestHttp(url, 'post', params, successCallBack, errorCallBack);
  }

  static requestHttp(String url, String method, params,
      Function successCallBack, Function errorCallBack) async {
    Response response;
    Map<String, dynamic> httpHeaders = {
      'Accept': 'application/json,*/*',
      'Content-Type': 'application/json',
      'token': HttpUtil.token
    };
    var options = BaseOptions(
        baseUrl: httpUrl,
        // 超时时间
        connectTimeout: 5000,
        // 接收数据最长时间
        receiveTimeout: 3000,
        headers: httpHeaders,
        responseType: ResponseType.json
        // 数据格式
        );
    dio.options = options;
    try {
      if (method == 'get') {
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
        if (params != null && params.length > 0) {
          response = await dio.get(
            url,
            queryParameters: params,
            options: buildCacheOptions(Duration(days: 7),
                maxStale: Duration(minutes: 1)),
          );
        } else {
          response = await dio.get(url);
        }
      } else {
        if (params != null && params.length > 0) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
      successCallBack(response.data);
    } on DioError catch (error) {
      // 请求错误处理
      if (error.response != null) {
        response = error.response!;
      } else {
        response = new Response(
            statusCode: 666, requestOptions: new RequestOptions(path: ''));
      }
      // 请求超时
      if (error.type == DioErrorType.connectTimeout) {
        response.statusCode = ResultCode.CONNECT_TIMEOUT;
        EasyLoading.showError("连接服务器超时");
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.receiveTimeout) {
        response.statusCode = ResultCode.RECEIVE_TIMEOUT;
        EasyLoading.showError("接收服务器超时");
      }

      // debug模式才打印
      if (GlobalConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + dio.options.headers.toString());
        print('method: ' + dio.options.method);
      }

      errorCallBack(response);
      EasyLoading.dismiss();
    }
  }
}
