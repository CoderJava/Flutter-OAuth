import 'package:dio/dio.dart';
import 'package:flutter_sample_oauth/src/api/api_auth_repository.dart';
import 'package:flutter_sample_oauth/src/injector/injector.dart';
import 'package:flutter_sample_oauth/src/model/refreshtoken/refresh_token_body.dart';
import 'package:flutter_sample_oauth/src/model/token/token.dart';
import 'package:flutter_sample_oauth/src/storage/sharedpreferences/shared_preferences_manager.dart';

class DioLoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();

  DioLoggingInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    print("--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print("--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    if (options.headers.containsKey('requiresToken')) {
      options.headers.remove('requiresToken');
      print('accessToken: ${_sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken)}');
      String accessToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    return options;
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    print(
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("<-- End error");

    int responseCode = dioError.response.statusCode;
    String oldAccessToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
    if (oldAccessToken != null && responseCode == 401 && _sharedPreferencesManager != null) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      String refreshToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyRefreshToken);
      RefreshTokenBody refreshTokenBody = RefreshTokenBody('refresh_token', refreshToken);
      ApiAuthRepository apiAuthRepository = ApiAuthRepository();
      Token token = await apiAuthRepository.postRefreshAuth(refreshTokenBody);
      String newAccessToken = token.accessToken;
      String newRefreshToken = token.refreshToken;
      await _sharedPreferencesManager.putString(SharedPreferencesManager.keyAccessToken, newAccessToken);
      await _sharedPreferencesManager.putString(SharedPreferencesManager.keyRefreshToken, newRefreshToken);

      RequestOptions options = dioError.response.request;
      options.headers.addAll({'requiresToken': true});
      _dio.interceptors.requestLock.unlock();
      _dio.interceptors.responseLock.unlock();
      return _dio.request(options.path, options: options);
    } else {
      super.onError(dioError);
    }
  }
}
